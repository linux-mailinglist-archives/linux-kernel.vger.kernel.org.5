Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBEA7E65C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjKIIy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjKIIy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:54:58 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC851A4;
        Thu,  9 Nov 2023 00:54:54 -0800 (PST)
X-UUID: 3900c660da5e4cf2b348184e57410291-20231109
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:cda4ced0-dae3-4949-9d13-c6be1de23bf2,IP:15,
        URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-15
X-CID-INFO: VERSION:1.1.32,REQID:cda4ced0-dae3-4949-9d13-c6be1de23bf2,IP:15,UR
        L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-15
X-CID-META: VersionHash:5f78ec9,CLOUDID:9e98dd5f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:231109163617DP84HWM9,BulkQuantity:1,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 3900c660da5e4cf2b348184e57410291-20231109
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <heminhong@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 187487715; Thu, 09 Nov 2023 16:54:44 +0800
From:   heminhong <heminhong@kylinos.cn>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        heminhong <heminhong@kylinos.cn>
Subject: [PATCH] tools/gpio: prevent resource leak
Date:   Thu,  9 Nov 2023 16:54:19 +0800
Message-Id: <20231109085419.84948-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the main() function, the open() function is used to open the file.
When the file is successfully opened, fd is used to interact with the file,
but the fd is not closed, it will cause resource leak.

Signed-off-by: heminhong <heminhong@kylinos.cn>
---
 tools/gpio/gpio-watch.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/gpio/gpio-watch.c b/tools/gpio/gpio-watch.c
index 41e76d244192..162c2a8f07c8 100644
--- a/tools/gpio/gpio-watch.c
+++ b/tools/gpio/gpio-watch.c
@@ -42,11 +42,14 @@ int main(int argc, char **argv)
 		memset(&req, 0, sizeof(req));
 
 		req.offset = strtoul(argv[j], &end, 0);
-		if (*end != '\0')
+		if (*end != '\0') {
+			close(fd);
 			goto err_usage;
+		}
 
 		ret = ioctl(fd, GPIO_V2_GET_LINEINFO_WATCH_IOCTL, &req);
 		if (ret) {
+			close(fd);
 			perror("unable to set up line watch");
 			return EXIT_FAILURE;
 		}
@@ -58,6 +61,7 @@ int main(int argc, char **argv)
 	for (;;) {
 		ret = poll(&pfd, 1, 5000);
 		if (ret < 0) {
+			close(pfd.fd);
 			perror("error polling the linechanged fd");
 			return EXIT_FAILURE;
 		} else if (ret > 0) {
@@ -66,7 +70,7 @@ int main(int argc, char **argv)
 			if (rd < 0 || rd != sizeof(chg)) {
 				if (rd != sizeof(chg))
 					errno = EIO;
-
+				close(pfd.fd);
 				perror("error reading line change event");
 				return EXIT_FAILURE;
 			}
@@ -82,6 +86,7 @@ int main(int argc, char **argv)
 				event = "config changed";
 				break;
 			default:
+				close(pfd.fd);
 				fprintf(stderr,
 					"invalid event type received from the kernel\n");
 				return EXIT_FAILURE;
@@ -91,7 +96,7 @@ int main(int argc, char **argv)
 			       chg.info.offset, event, (uint64_t)chg.timestamp_ns);
 		}
 	}
-
+	close(pfd.fd);
 	return 0;
 
 err_usage:
-- 
2.25.1


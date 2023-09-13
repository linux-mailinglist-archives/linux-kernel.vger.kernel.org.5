Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F58279F400
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjIMVsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIMVsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:48:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558601739;
        Wed, 13 Sep 2023 14:47:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8D2C433C8;
        Wed, 13 Sep 2023 21:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694641677;
        bh=ulSrj+T9NqdrdSB2rEZPgPGJhO75blW4ggcLU8BdGdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=osJIR1cgrxYhGHFRhlduP+Bo7ARo6ROashTdOMScqrYSyg4nXzBZDGjVtCRyQeyqv
         EFx9znGeYXOXrykfXgMNcr+NGVKvqapyeSpjV1QAU0MpYxye+57Av+zozUwyZ5LK2P
         SwYz9JIwKj8dhFWm/ObQVc4k/XtN8FwnBRrgLmbJ7lpi3QicUgtTO7Oec1G0XXI5vC
         U1PwoUeHKAW1PAKR9xO4JFd15AnqNMIIaBpGcC+mhy/A+FqeffgoCNgywaJ2Bsc4sG
         r2YQU15jldMHuI3FZVpUPloQ15idG6MZz95tQbsDbbAqSGcvwsQQyhqan3m7oaLFHI
         AkVyP/iT8+POg==
Date:   Wed, 13 Sep 2023 23:47:53 +0200
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Sep 13 (objtool)
Message-ID: <20230913214753.3xqemkqjhxcwqaz4@treble>
References: <20230913150445.49bee094@canb.auug.org.au>
 <a53f9840-8581-44cc-beaf-6fb644c8cacc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a53f9840-8581-44cc-beaf-6fb644c8cacc@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 01:34:11PM -0700, Randy Dunlap wrote:
> 
> 
> On 9/12/23 22:04, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20230912:
> > 
> > The bpf-next tree (I think) gained a boot time warning due to a semantic
> > interaction with changes in the bpf tree.
> > 
> > The drm-misc tree gained a conflict against Linus' tree.
> > 
> > Non-merge commits (relative to Linus' tree): 4427
> >  1907 files changed, 354449 insertions(+), 27039 deletions(-)
> > 
> > ----------------------------------------------------------------------------
> 
> on x86_64:
> 
> drivers/media/common/siano/smscoreapi.o: warning: objtool: .text.unlikely: unexpected end of section
> 
> Full randconfig file is attached.

Objtool is correct:

  Disassembly of section .text.unlikely:

  0000000000000000 <smscore_set_device_mode.cold>:
     0:   48 83 05 00 00 00 00 01         addq   $0x1,0x0(%rip)        # 8 <__UNIQUE_ID___addressable_smscore_unregister_client433>       3: R_X86_64_PC32        .bss+0xa03

It's not really a functional bug, it's just gcov somehow keeping GCC
from finishing an optimization.

In smscore_load_firmware_from_file(), which gets inlined by
smscore_set_device_mode(), GCC is smart enough to know that

  'coredev->device_flags & SMS_DEVICE_FAMILY2'

is always true, so it half-optimizes out the ':' condition:

		rc = (coredev->device_flags & SMS_DEVICE_FAMILY2) ?
			smscore_load_firmware_family2(coredev, fw_buf, fw_buf_size)
			: loadfirmware_handler(coredev->context, fw_buf,
			fw_buf_size);

Though it actually still keeps the branch.  It goes to
smscore_set_device_mode.cold so it can set the GCOV "branch taken" bit
for the !SMS_DEVICE_FAMILY2 case.  But then it just falls off the edge
off .text.unlikely.

Peter, any opinions how to handle this?

We could just make smscore_load_firmware_from_file() noinline.

Or we could hard-code the fact that smscore_load_firmware_from_file() is
only called in the SMS_DEVICE_FAMILY2 case, like:

diff --git a/drivers/media/common/siano/smscoreapi.c b/drivers/media/common/siano/smscoreapi.c
index 7d4bc2733f2b..58d951903e93 100644
--- a/drivers/media/common/siano/smscoreapi.c
+++ b/drivers/media/common/siano/smscoreapi.c
@@ -1127,19 +1127,19 @@ static char *smscore_get_fw_filename(struct smscore_device_t *coredev,
  * @param coredev pointer to a coredev object returned by
  *                smscore_register_device
  * @param filename null-terminated string specifies firmware file name
- * @param loadfirmware_handler device handler that loads firmware
  *
  * return: 0 on success, <0 on error.
  */
 static int smscore_load_firmware_from_file(struct smscore_device_t *coredev,
-					   int mode,
-					   loadfirmware_t loadfirmware_handler)
+					   int mode)
 {
 	int rc = -ENOENT;
 	u8 *fw_buf;
 	u32 fw_buf_size;
 	const struct firmware *fw;
 
+	BUG_ON(coredev->device_flags != SMS_DEVICE_FAMILY2);
+
 	char *fw_filename = smscore_get_fw_filename(coredev, mode);
 	if (!fw_filename) {
 		pr_err("mode %d not supported on this device\n", mode);
@@ -1147,10 +1147,6 @@ static int smscore_load_firmware_from_file(struct smscore_device_t *coredev,
 	}
 	pr_debug("Firmware name: %s\n", fw_filename);
 
-	if (!loadfirmware_handler &&
-	    !(coredev->device_flags & SMS_DEVICE_FAMILY2))
-		return -EINVAL;
-
 	rc = request_firmware(&fw, fw_filename, coredev->device);
 	if (rc < 0) {
 		pr_err("failed to open firmware file '%s'\n", fw_filename);
@@ -1166,10 +1162,7 @@ static int smscore_load_firmware_from_file(struct smscore_device_t *coredev,
 		memcpy(fw_buf, fw->data, fw->size);
 		fw_buf_size = fw->size;
 
-		rc = (coredev->device_flags & SMS_DEVICE_FAMILY2) ?
-			smscore_load_firmware_family2(coredev, fw_buf, fw_buf_size)
-			: loadfirmware_handler(coredev->context, fw_buf,
-			fw_buf_size);
+		rc = smscore_load_firmware_family2(coredev, fw_buf, fw_buf_size);
 	}
 
 	kfree(fw_buf);
@@ -1353,8 +1346,7 @@ int smscore_set_device_mode(struct smscore_device_t *coredev, int mode)
 		}
 
 		if (!(coredev->modes_supported & (1 << mode))) {
-			rc = smscore_load_firmware_from_file(coredev,
-							     mode, NULL);
+			rc = smscore_load_firmware_from_file(coredev, mode);
 			if (rc >= 0)
 				pr_debug("firmware download success\n");
 		} else {

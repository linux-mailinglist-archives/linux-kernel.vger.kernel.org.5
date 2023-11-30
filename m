Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7331A7FFC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376647AbjK3UMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376627AbjK3UMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:12:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D446170D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:12:25 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d05199f34dso294145ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701375145; x=1701979945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxiCx504yHLmFes8dR2H4gaz2egSElvJRBaPgOOtpHk=;
        b=GtpZEhQ0i3uv0aQzJhmOwj4huUqIWHViM7T9FWTkpBpiV5QlfizYMV7TJykNrUI+m3
         Q6qB1l7mGoQFSLWuEFVtrSqxmxOLmc/DwWuA1L2IHmPDDYmhroqKlvypHwHr0whZ64/q
         3B22eUh4TXmIM7UpcQOZhGY7opnxgPgx4CO0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375145; x=1701979945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxiCx504yHLmFes8dR2H4gaz2egSElvJRBaPgOOtpHk=;
        b=q9bfAeFh6DVO0PH0dVGA7AKCJ1WATgdlqWFYcC4keoZnmlUA1OkhQ/Cp8hiU4qEPjb
         GI8pCI3rbX3cc/vJUVM1zyt+Lrqa+dbGdiVWGHiKyYRrABRO3KTPqoZlRmbHj/Unaiy4
         PWl1tJ+CzOtBf98ht+915UiM37BCtDt1MUXJ9cYZ1iNSPltS8GGwwiWnBhD7UPt/qY27
         qIKl0tKwIwVL/Txy5UYRFqRDa92z08s5eMSiaoIlgRkIkcRsxSv1ej0wDItMIYVm/MJ3
         Ws2OvOTD4VM05FF/4U+JojWPNzzdT2pRqZpSeB25ZZXo19hteFyRWJPZozJRjrgyOru2
         cqtA==
X-Gm-Message-State: AOJu0YxpIEE9BYLB8XGsdE/sd6lvusATWngJ4rAOqKC8z+Xi07z34hKa
        jzWWKkqlpx8ynKotydA2w52Oig==
X-Google-Smtp-Source: AGHT+IEGq93c/Iw/ZgddCDWopgpI+b7c8CTq5jVvTxu7Bu3lG3iJaOBkaRAMLQswM+i4fu1EBHU5yA==
X-Received: by 2002:a17:903:228a:b0:1cf:b146:8101 with SMTP id b10-20020a170903228a00b001cfb1468101mr24098384plh.16.1701375145110;
        Thu, 30 Nov 2023 12:12:25 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902a71400b001d0242c0471sm1794719plq.224.2023.11.30.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:12:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/3] kernfs: Convert kernfs_name_locked() from strlcpy() to strscpy()
Date:   Thu, 30 Nov 2023 12:12:18 -0800
Message-Id: <20231130201222.3613535-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130200937.it.424-kees@kernel.org>
References: <20231130200937.it.424-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2637; i=keescook@chromium.org;
 h=from:subject; bh=JAJdaxInWUYVNuwIwA8b/GPyHonLetqQSJoS2H+M0wM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaOyjBNLwq83oMtldatGW+UhXwbgyaP8FTFySX
 SrtWyh/9ueJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWjsowAKCRCJcvTf3G3A
 Jm5zEAClKw3heuKsLAxhXMgbSIvAPXK7qmEyDktGCUWVn1nRNWVFKPNbaM01zKM6050NbOlC/Dn
 uHrkNUwjUwO7nl6cOoI/ErwkWj2InKd2UEFHBUT6pyggumpGWZNGf2epzUNP3DCJzOeqisxmzmD
 uPN3+cV/yRUGoq6iq8EbLsxDUJSHugfyoLTcOWPwP8hKqBj4GPSNCFhpH5ZPEQCMqACjPOu75j+
 3+KwBNLt7nLsTn7ilAVoU6TeRmlmnv4tAcwJvyCnxMmAuDcDgUsqOwhYcgC8oaLVtrLq0iwDbvQ
 d2mJGliCeakISYslS0pxjlvSWeDJOByZqMADBLBuGZNR/s3UhTqI8drb12NldkzMm8D9JovJmMk
 pRdfjGXUFNyfN5DemTVLaAPtyVj+gTVMJADvEVjgsrq0VYa1aLze+oSJrdDC+zYUQwCdF45ov/w
 /tF0FwTz0byrsC+ytvYt0nw1i7ZdFuMoqoouLFMnPt5o3gpVcwcDFeT9y39usX08lUVfbsCKskj
 NbbDSDRzieaHqFBWAs+hFF8O3E02Kk+Y9moy6eang5KQgS3ahdWwW3WDKuygWRZ/ZT4kTh4ECN6
 AF8ycj65cPRGIh1uBMGlaLk5MNeGMk07XH5aiPhWTCHOuGSqnzeFqy6MCC8VAisSJ2ZCeEBWPVt 71IQ/lmUUzgov6Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Nothing actually checks the return value coming from kernfs_name_locked(),
so this has no impact on error paths. The caller hierarchy is:

kernfs_name_locked()
        kernfs_name()
                pr_cont_kernfs_name()
                        return value ignored
                cgroup_name()
                        current_css_set_cg_links_read()
                                return value ignored
                        print_page_owner_memcg()
                                return value ignored

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Link: https://lore.kernel.org/r/20231116192127.1558276-2-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/kernfs/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 37353901ede1..8c0e5442597e 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -54,9 +54,9 @@ static bool kernfs_lockdep(struct kernfs_node *kn)
 static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
 {
 	if (!kn)
-		return strlcpy(buf, "(null)", buflen);
+		return strscpy(buf, "(null)", buflen);
 
-	return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
+	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
 }
 
 /* kernfs_node_depth - compute depth from @from to @to */
@@ -182,12 +182,12 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
  * @buflen: size of @buf
  *
  * Copies the name of @kn into @buf of @buflen bytes.  The behavior is
- * similar to strlcpy().
+ * similar to strscpy().
  *
  * Fills buffer with "(null)" if @kn is %NULL.
  *
- * Return: the length of @kn's name and if @buf isn't long enough,
- * it's filled up to @buflen-1 and nul terminated.
+ * Return: the resulting length of @buf. If @buf isn't long enough,
+ * it's filled up to @buflen-1 and nul terminated, and returns -E2BIG.
  *
  * This function can be called from any context.
  */
-- 
2.34.1


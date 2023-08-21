Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57757821A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjHUCnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjHUCnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:43:46 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CB09C;
        Sun, 20 Aug 2023 19:43:42 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34baf19955cso9775665ab.2;
        Sun, 20 Aug 2023 19:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692585822; x=1693190622;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pTs649jeA9tAOqsDzauJjFvBqiDtGSzL0YrvYTEwtc0=;
        b=RFbbJ7k8CSMD8My5cNBZhD2EsbrmicQmSok1r+2NG5M1SU7CPw3jrwvTrpdOt6eVO2
         QTfAS3e6OmGJqf2HLCtysU7yS9J2Jmj6HWlnJrfh01AX7tzh3vjJd5EU7GbgS94mHAwF
         Xdkdy+bIGLFV381MYmh69ScuHPM8exdouQZObN1N+iQpQ1SIQ8i60oWh6Ca1jySxJIx9
         silS6Y8DOxvHM64fzvZzGoSCCsoSn6GLich0pm9QGC1Z40KQEN8Pvj4LLfRo5bUNXuwa
         dSdZT0lZuKkRLapuXh5CKDunrNiz9HszBEbNGLskH3oTgzSY7gZ6yCtPxVBSexKqRfri
         TCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692585822; x=1693190622;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pTs649jeA9tAOqsDzauJjFvBqiDtGSzL0YrvYTEwtc0=;
        b=HQbfXPeblAPywF11hdyrQmoAWhJGr9ub0FZ6NF7PF0uT3OmJuAqE4DA8AdbYJErFCC
         dFCF4F89QxTjyIVkhpOf5VUHUmIuzfEDjzVwWTbj/nVCmUtQs5Uv279QX3JUE6GRXlCF
         0tQVk81oetyJ43DNP0xZ+CAkroGyw+Y7MwupilxNthVtNEFFexXxjGC+b5v875Nij/Ps
         v3rpiNXLw1fB3X3NtvFw4wrT9K88mmk0HJiCDTIFXE0Z26fUiqv062oMd8Y5ArunUTlg
         G9jAPy7rIuIn1MXMrRtTTXGSFHLxGDgR7P9EkCTlsZEIK3K1lj2AAfYI+Ha86kBep2ID
         UXIg==
X-Gm-Message-State: AOJu0YzFywrM2rArT7w3ijK5HTQ+mx5uoHyWxd8gLiBLTxU1iu7aMFrM
        yaGL+DaqifEcwux9DHDCfGrGyVAcYxKEScWtzY1HKGsQdq08lw==
X-Google-Smtp-Source: AGHT+IGQlKpY+eX+IltkCPBAaaoADlZ6ulJwBa+9Dbj5qsHffgXx6FRuG5834augCy++JDpDHeoro8MWvEz8im4xGhM=
X-Received: by 2002:a05:6e02:118f:b0:34b:ad46:c3ab with SMTP id
 y15-20020a056e02118f00b0034bad46c3abmr6281248ili.7.1692585821856; Sun, 20 Aug
 2023 19:43:41 -0700 (PDT)
MIME-Version: 1.0
From:   Nathan French <nathanmfrench17@gmail.com>
Date:   Sun, 20 Aug 2023 21:43:32 -0500
Message-ID: <CACp1nnB_nXtxAxNzoDqcDg=FTzQbxt14SFSTqN8tAE4fn_AQyw@mail.gmail.com>
Subject: [PATCH][ksmbd] fix UAF in ksmbd_alloc_work_struct
To:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linkinjeon@kernel.org
Content-Type: multipart/mixed; boundary="000000000000a9fbcb060365d8ba"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a9fbcb060365d8ba
Content-Type: text/plain; charset="UTF-8"

    avoid oops accessing null work struct pointer

    Fixes: bdf1b0e2a1ea ("ksmbd_alloc_work_struct")
    Addresses-Coverity: 1566875 ("Explicit null dereference")
    Reviewed-by: Jackson Winslow <jackwinslow35@gmail.com>
    Signed-off-by: Nathan French <nathanmfrench17@gmail.com>

diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index 51def3ca74c0..9411f7e32a3c 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
@@ -33,7 +33,7 @@ struct ksmbd_work *ksmbd_alloc_work_struct(void)
                                    GFP_KERNEL);
                if (!work->iov) {
                        kmem_cache_free(work_cache, work);
-                       work = NULL;
+                       return NULL;
                }
        }
        return work;

--000000000000a9fbcb060365d8ba
Content-Type: application/octet-stream; 
	name="0001-ksmbd-fix-UAF-in-ksmbd_alloc_work_struct.patch"
Content-Disposition: attachment; 
	filename="0001-ksmbd-fix-UAF-in-ksmbd_alloc_work_struct.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_llk9w05h0>
X-Attachment-Id: f_llk9w05h0

RnJvbSBjMTM4MTc0NDFjODYwZmVjMTRjYzlkNDMzNzE5YjgzY2E3ZGUxZWQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYXRoYW4gRnJlbmNoIDxuYXRoYW5tZnJlbmNoMTdAZ21haWwu
Y29tPgpEYXRlOiBNb24sIDIxIEF1ZyAyMDIxIDAyOjE3OjA0ICswMDAwClN1YmplY3Q6IFtQQVRD
SF0ga3NtYmQ6IGZpeCBVQUYgaW4ga3NtYmRfYWxsb2Nfd29ya19zdHJ1Y3QKCmF2b2lkIG9vcHMg
YWNjZXNzaW5nIG51bGwgd29yayBzdHJ1Y3QgcG9pbnRlcgoKRml4ZXM6IGJkZjFiMGUyYTFlYSAo
ImtzbWJkX2FsbG9jX3dvcmtfc3RydWN0IikKQWRkcmVzc2VzLUNvdmVyaXR5OiAxNTY2ODc1ICgi
RXhwbGljaXQgbnVsbCBkZXJlZmVyZW5jZSIpClJldmlld2VkLWJ5OiBKYWNrc29uIFdpbnNsb3cg
PGphY2t3aW5zbG93MzVAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBOYXRoYW4gRnJlbmNoIDxu
YXRoYW5tZnJlbmNoMTdAZ21haWwuY29tPgotLS0KIGZzL3NtYi9zZXJ2ZXIva3NtYmRfd29yay5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZnMvc21iL3NlcnZlci9rc21iZF93b3JrLmMgYi9mcy9zbWIvc2VydmVyL2tz
bWJkX3dvcmsuYwppbmRleCA1MWRlZjNjYTc0YzAuLjk0MTFmN2UzMmEzYyAxMDA2NDQKLS0tIGEv
ZnMvc21iL3NlcnZlci9rc21iZF93b3JrLmMKKysrIGIvZnMvc21iL3NlcnZlci9rc21iZF93b3Jr
LmMKQEAgLTMzLDcgKzMzLDcgQEAgc3RydWN0IGtzbWJkX3dvcmsgKmtzbWJkX2FsbG9jX3dvcmtf
c3RydWN0KHZvaWQpCiAJCQkJICAgIEdGUF9LRVJORUwpOwogCQlpZiAoIXdvcmstPmlvdikgewog
CQkJa21lbV9jYWNoZV9mcmVlKHdvcmtfY2FjaGUsIHdvcmspOwotCQkJd29yayA9IE5VTEw7CisJ
CQlyZXR1cm4gTlVMTDsKIAkJfQogCX0KIAlyZXR1cm4gd29yazsKLS0gCjIuMzkuMgoK
--000000000000a9fbcb060365d8ba--

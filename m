Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60E977D9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 07:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241873AbjHPF3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 01:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbjHPF2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:28:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4713C1FC7;
        Tue, 15 Aug 2023 22:28:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso812869766b.1;
        Tue, 15 Aug 2023 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692163729; x=1692768529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oI9EbUbdFX+RrThKFfE8bckQkP7vk+YwcykLWlRyZmc=;
        b=pVHILuPrelt8olO6J3x6t/JNyuP+8amxy7PYit2QNk6GKT26n4acrJxjECq9+khi+n
         6r6y9zU8Y1KgZF3Pg/SLchBo04Ia9kd+/goffo1ag0frUlBD9WAehmnn8/Nk9uf8H0Op
         g5gVHsf2/RhSfwkfwgWF/rGKxyhlzJghbagqEm4yE5bAomBKCsP6FxJuYd1HwHQnFJgO
         kKW9o0qUVVy+ljmlqdYGjh31Z4XyuoDKQMP9hu5ILLFk9FOfMkCiZUy1yYzhSElHO9uR
         UeIqSDy4FzGyHCVDLLCRyF6aoqkq4v+9Ov1tw+uREDnUJybAqlXvOudp5JBvqJu1vQiu
         L4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692163729; x=1692768529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oI9EbUbdFX+RrThKFfE8bckQkP7vk+YwcykLWlRyZmc=;
        b=cP7vAmAoFbvb2WBRtfS7ma/i8QzUhyHcx4fjbThzI51e38lOz7+Cg+iLkAQvG4+S4w
         r41P4YjJUGOv2AnrDnf0TQXRMmgLDg5kiWcuGZ3vHwTqzg2NlgSyjhERBqgS1p/T1rK8
         Rpni2njvPI8oQaWkMOJxWcCSwUjPCzUKuZqyixx1kQGQivT+7ZMlRdkzNNayvt1DfOd7
         PFRzwowREae1bjacUmB64FlEUBD9T3xpT5weL5uxaeRKpyzMbdH125qjzkfT6de5L/kF
         1moAuRhTSalyM4Tph8K38ylOnYVR4w1UizX51Gvc6RhZ4QhpOUSduNJT5eO0XaoiIcbf
         QEkw==
X-Gm-Message-State: AOJu0Yw/sUIrDQaosdTS9xsFAnfr8ve8w5o/lKKGeSa40HTYUMHXj+Ea
        kyDaPXFa/K8/kfEEoiqTVkh3BAV3bbz6OaN+lWo=
X-Google-Smtp-Source: AGHT+IHSF+TLanoCC/zz7iEYIVfKfhNYq8rVc5R2wapF465iYq1NHWQsc0WUGyq7xOotb7ciDMOqbS1Diw9kIuc+dZY=
X-Received: by 2002:a17:907:1de0:b0:99d:f2dc:97e3 with SMTP id
 og32-20020a1709071de000b0099df2dc97e3mr307243ejc.20.1692163728394; Tue, 15
 Aug 2023 22:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230815-fix-cifs-null-auth-v1-1-3cb785216d97@redhat.com> <2f7522c01a45f9052f423869040258ba.pc@manguebit.com>
In-Reply-To: <2f7522c01a45f9052f423869040258ba.pc@manguebit.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 16 Aug 2023 00:28:36 -0500
Message-ID: <CAH2r5msYemdM+J_ETsrHOkxmm4qeDnA8cLYOHVA9LhfjoBnYuQ@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix null auth
To:     Paulo Alcantara <pc@manguebit.com>
Cc:     Scott Mayhew <smayhew@redhat.com>,
        Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        Steve French <stfrench@microsoft.com>
Content-Type: multipart/mixed; boundary="000000000000eee10a060303917c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000eee10a060303917c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fixed some checkpatch warnings and added Paulo's RB, and updated
cifs-2.6.git for-next


On Tue, Aug 15, 2023 at 1:42=E2=80=AFPM Paulo Alcantara via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> Scott Mayhew <smayhew@redhat.com> writes:
>
> > Commit abdb1742a312 removed code that clears ctx->username when
> > sec=3Dnone, so attempting to mount with '-o sec=3Dnone' now fails with
> > -EACCES.  Fix it by adding that logic to the parsing of the 'sec'
> > option, as well as checking if the mount is using null auth before
> > setting the username when parsing the 'user' option.
> >
> > Fixes: abdb1742a312 ("cifs: get rid of mount options string parsing")
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  fs/smb/client/fs_context.c | 4 ++++
> >  1 file changed, 4 insertions(+)
>
> Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
>


--=20
Thanks,

Steve

--000000000000eee10a060303917c
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-smb-client-fix-null-auth.patch"
Content-Disposition: attachment; 
	filename="0001-smb-client-fix-null-auth.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lldakw8n0>
X-Attachment-Id: f_lldakw8n0

RnJvbSAyNzBkNzNlNjUwN2Y5YzdmZmY0Mzg0NGQ3NGY4NjM2NWRmMDAwYjM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTY290dCBNYXloZXcgPHNtYXloZXdAcmVkaGF0LmNvbT4KRGF0
ZTogV2VkLCAxNiBBdWcgMjAyMyAwMDoyMzo1NiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIHNtYjog
Y2xpZW50OiBmaXggbnVsbCBhdXRoCgpDb21taXQgYWJkYjE3NDJhMzEyIHJlbW92ZWQgY29kZSB0
aGF0IGNsZWFycyBjdHgtPnVzZXJuYW1lIHdoZW4gc2VjPW5vbmUsIHNvIGF0dGVtcHRpbmcKdG8g
bW91bnQgd2l0aCAnLW8gc2VjPW5vbmUnIG5vdyBmYWlscyB3aXRoIC1FQUNDRVMuICBGaXggaXQg
YnkgYWRkaW5nIHRoYXQgbG9naWMgdG8gdGhlCnBhcnNpbmcgb2YgdGhlICdzZWMnIG9wdGlvbiwg
YXMgd2VsbCBhcyBjaGVja2luZyBpZiB0aGUgbW91bnQgaXMgdXNpbmcgbnVsbCBhdXRoIGJlZm9y
ZQpzZXR0aW5nIHRoZSB1c2VybmFtZSB3aGVuIHBhcnNpbmcgdGhlICd1c2VyJyBvcHRpb24uCgpG
aXhlczogYWJkYjE3NDJhMzEyICgiY2lmczogZ2V0IHJpZCBvZiBtb3VudCBvcHRpb25zIHN0cmlu
ZyBwYXJzaW5nIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogU2Nv
dHQgTWF5aGV3IDxzbWF5aGV3QHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBQYXVsbyBBbGNhbnRh
cmEgKFNVU0UpIDxwY0BtYW5ndWViaXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2gg
PHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvc21iL2NsaWVudC9mc19jb250ZXh0LmMg
fCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9m
cy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuYyBiL2ZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5jCmlu
ZGV4IDQ5NDZhMGM1OTYwMC4uNjdlMTZjMmFjOTBlIDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50
L2ZzX2NvbnRleHQuYworKysgYi9mcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuYwpAQCAtMjMxLDYg
KzIzMSw4IEBAIGNpZnNfcGFyc2Vfc2VjdXJpdHlfZmxhdm9ycyhzdHJ1Y3QgZnNfY29udGV4dCAq
ZmMsIGNoYXIgKnZhbHVlLCBzdHJ1Y3Qgc21iM19mc19jCiAJCWJyZWFrOwogCWNhc2UgT3B0X3Nl
Y19ub25lOgogCQljdHgtPm51bGxhdXRoID0gMTsKKwkJa2ZyZWUoY3R4LT51c2VybmFtZSk7CisJ
CWN0eC0+dXNlcm5hbWUgPSBOVUxMOwogCQlicmVhazsKIAlkZWZhdWx0OgogCQljaWZzX2Vycm9y
ZihmYywgImJhZCBzZWN1cml0eSBvcHRpb246ICVzXG4iLCB2YWx1ZSk7CkBAIC0xMjAxLDYgKzEy
MDMsOCBAQCBzdGF0aWMgaW50IHNtYjNfZnNfY29udGV4dF9wYXJzZV9wYXJhbShzdHJ1Y3QgZnNf
Y29udGV4dCAqZmMsCiAJY2FzZSBPcHRfdXNlcjoKIAkJa2ZyZWUoY3R4LT51c2VybmFtZSk7CiAJ
CWN0eC0+dXNlcm5hbWUgPSBOVUxMOworCQlpZiAoY3R4LT5udWxsYXV0aCkKKwkJCWJyZWFrOwog
CQlpZiAoc3RybGVuKHBhcmFtLT5zdHJpbmcpID09IDApIHsKIAkJCS8qIG51bGwgdXNlciwgaWUu
IGFub255bW91cyBhdXRoZW50aWNhdGlvbiAqLwogCQkJY3R4LT5udWxsYXV0aCA9IDE7Ci0tIAoy
LjM0LjEKCg==
--000000000000eee10a060303917c--

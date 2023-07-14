Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23031754078
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjGNR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjGNR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:29:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A842691
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:29:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so6655e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689355795; x=1691947795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u6Ug2JjEvafULqpnxSJIRgizCvEmKYgRSPlSpkcAlBY=;
        b=eaqrxfZDQWxGoJGV8E1z6HlrIovZfrC65knnEx9LIgcqiA318jtZ84gBxdlDScWKaH
         0Guw23Un5fed370sxdknBlmvr4Ul36WLu71G6dpNtFhupCIcLQuWFgi38n5xIjkUkjxj
         kNUDoH/O6Nz/fALpw1jdCZ7aLE/0Ugr4bjvWXMFATLc8o2lGcZuAkTQg2+L87/dXTmTH
         JMViCYTb5K2KXGcaIFz7sgJN+z5zaOktGhDN//tbdQSbkXLPqMzUF4+mt3w55rJeX9xK
         XaDusJy7NHLHFoTCMaQf33PX0yjd4/LCRoENxkMCLQnlSQ2S/PbwsC9TXw90kQSB1hRS
         lo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355795; x=1691947795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6Ug2JjEvafULqpnxSJIRgizCvEmKYgRSPlSpkcAlBY=;
        b=Mw+zbxEiCXsfYkm0UrxzDJ3fGltUDDmejEv81UlV19xPBEFTI16FzrAftqFVzni725
         psr8q0dpfUFzNxmuHVVRz2Lqgd0cxv8bDmc9WmwLPNJuaxln/dArmxtwbX0A8GWpuBRV
         WFnZ6JexZ30XECUMJTWPPgEJVSNm9AVYLMDS4a/3SdcbTwTmDePWUbN9fjymvgpwOpz/
         a35i0H1DS5RE9K2M2u1jy0xUilljO3clgI7PILDhXxhHVweqObpXb1APkkFcJ3ht1ZON
         xRM5Ndn2rnT9x7EgHgF2q/VFRgUZxMta8niOYfuIMFZrwDEZGWDRtyDabuP1PfiprZNT
         g3zQ==
X-Gm-Message-State: ABy/qLbRYgQAhgRkhrHpyTefghcwsLef60n9VDX+8bRdyUFMIfBt1wSB
        5u2hTfXVnRv9h4/OYjfx6Zt5m7WoZujST7OaEWpd3A==
X-Google-Smtp-Source: APBJJlEv0c2UpOsAts/Qp7F2tRkqXT63pR6yJCt4OakTatG5GAX8OR31f53rucFmYwL09mYCLQUYrclNtXowa3aAnXM=
X-Received: by 2002:a7b:c446:0:b0:3fb:c838:c681 with SMTP id
 l6-20020a7bc446000000b003fbc838c681mr372218wmi.4.1689355794814; Fri, 14 Jul
 2023 10:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230321070141.2434-1-hdanton@sina.com> <000000000000f91f1405f7640e06@google.com>
In-Reply-To: <000000000000f91f1405f7640e06@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 14 Jul 2023 19:29:42 +0200
Message-ID: <CANp29Y5yq5hTcJ=VRjSXe+Fg0H=xqj7ajhk-eYBPEPZE4kHC+w@mail.gmail.com>
Subject: Re: [syzbot] [fat?] possible deadlock in exc_page_fault
To:     syzbot <syzbot+6d274a5dc4fa0974d4ad@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000000d4d7b060075cc28"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000d4d7b060075cc28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it
master

Patch from https://lore.kernel.org/lkml/20230714084354.1959951-1-sj1557.seo=
@samsung.com/T/#u
is attached.

On Tue, Mar 21, 2023 at 8:33=E2=80=AFAM syzbot
<syzbot+6d274a5dc4fa0974d4ad@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger a=
ny issue:
>
> Reported-and-tested-by: syzbot+6d274a5dc4fa0974d4ad@syzkaller.appspotmail=
.com
>
> Tested on:
>
> commit:         e8d018dd Linux 6.3-rc3
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10a0f66ec8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd40f6d44826f6=
cf7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D6d274a5dc4fa097=
4d4ad
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Deb=
ian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D162abfaac8=
0000
>
> Note: testing is done by a robot and is best-effort only.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000f91f1405f7640e06%40google.com.

--0000000000000d4d7b060075cc28
Content-Type: application/octet-stream; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lk2usvm90>
X-Attachment-Id: f_lk2usvm90

ZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMKaW5kZXggOTU3NTc0
MTgwYTVlLi40ZTM3NDMzNDFjZTcgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L2Rpci5jCisrKyBiL2Zz
L2V4ZmF0L2Rpci5jCkBAIC0yMTQsNyArMjE0LDEwIEBAIHN0YXRpYyB2b2lkIGV4ZmF0X2ZyZWVf
bmFtZWJ1ZihzdHJ1Y3QgZXhmYXRfZGVudHJ5X25hbWVidWYgKm5iKQogCWV4ZmF0X2luaXRfbmFt
ZWJ1ZihuYik7CiB9CiAKLS8qIHNraXAgaXRlcmF0aW5nIGVtaXRfZG90cyB3aGVuIGRpciBpcyBl
bXB0eSAqLworLyoKKyAqIEJlZm9yZSBjYWxsaW5nIGRpcl9lbWl0KigpLCBzYmktPnNfbG9jayBz
aG91bGQgYmUgcmVsZWFzZWQKKyAqIGJlY2F1c2UgcGFnZSBmYXVsdCBjYW4gb2NjdXIgaW4gZGly
X2VtaXQqKCkuCisgKi8KICNkZWZpbmUgSVRFUl9QT1NfRklMTEVEX0RPVFMgICAgKDIpCiBzdGF0
aWMgaW50IGV4ZmF0X2l0ZXJhdGUoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBkaXJfY29udGV4
dCAqY3R4KQogewpAQCAtMjI5LDExICsyMzIsMTAgQEAgc3RhdGljIGludCBleGZhdF9pdGVyYXRl
KHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgZGlyX2NvbnRleHQgKmN0eCkKIAlpbnQgZXJyID0g
MCwgZmFrZV9vZmZzZXQgPSAwOwogCiAJZXhmYXRfaW5pdF9uYW1lYnVmKG5iKTsKLQltdXRleF9s
b2NrKCZFWEZBVF9TQihzYiktPnNfbG9jayk7CiAKIAljcG9zID0gY3R4LT5wb3M7CiAJaWYgKCFk
aXJfZW1pdF9kb3RzKGZpbGUsIGN0eCkpCi0JCWdvdG8gdW5sb2NrOworCQlnb3RvIG91dDsKIAog
CWlmIChjdHgtPnBvcyA9PSBJVEVSX1BPU19GSUxMRURfRE9UUykgewogCQljcG9zID0gMDsKQEAg
LTI0NSwxNiArMjQ3LDE4IEBAIHN0YXRpYyBpbnQgZXhmYXRfaXRlcmF0ZShzdHJ1Y3QgZmlsZSAq
ZmlsZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpCiAJLyogbmFtZSBidWZmZXIgc2hvdWxkIGJl
IGFsbG9jYXRlZCBiZWZvcmUgdXNlICovCiAJZXJyID0gZXhmYXRfYWxsb2NfbmFtZWJ1ZihuYik7
CiAJaWYgKGVycikKLQkJZ290byB1bmxvY2s7CisJCWdvdG8gb3V0OwogZ2V0X25ldzoKKwltdXRl
eF9sb2NrKCZFWEZBVF9TQihzYiktPnNfbG9jayk7CisKIAlpZiAoZWktPmZsYWdzID09IEFMTE9D
X05PX0ZBVF9DSEFJTiAmJiBjcG9zID49IGlfc2l6ZV9yZWFkKGlub2RlKSkKIAkJZ290byBlbmRf
b2ZfZGlyOwogCiAJZXJyID0gZXhmYXRfcmVhZGRpcihpbm9kZSwgJmNwb3MsICZkZSk7CiAJaWYg
KGVycikgewogCQkvKgotCQkgKiBBdCBsZWFzdCB3ZSB0cmllZCB0byByZWFkIGEgc2VjdG9yLiAg
TW92ZSBjcG9zIHRvIG5leHQgc2VjdG9yCi0JCSAqIHBvc2l0aW9uIChzaG91bGQgYmUgYWxpZ25l
ZCkuCisJCSAqIEF0IGxlYXN0IHdlIHRyaWVkIHRvIHJlYWQgYSBzZWN0b3IuCisJCSAqIE1vdmUg
Y3BvcyB0byBuZXh0IHNlY3RvciBwb3NpdGlvbiAoc2hvdWxkIGJlIGFsaWduZWQpLgogCQkgKi8K
IAkJaWYgKGVyciA9PSAtRUlPKSB7CiAJCQljcG9zICs9IDEgPDwgKHNiLT5zX2Jsb2Nrc2l6ZV9i
aXRzKTsKQEAgLTI3NywxNiArMjgxLDEwIEBAIHN0YXRpYyBpbnQgZXhmYXRfaXRlcmF0ZShzdHJ1
Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpCiAJCWludW0gPSBpdW5pcXVl
KHNiLCBFWEZBVF9ST09UX0lOTyk7CiAJfQogCi0JLyoKLQkgKiBCZWZvcmUgY2FsbGluZyBkaXJf
ZW1pdCgpLCBzYl9sb2NrIHNob3VsZCBiZSByZWxlYXNlZC4KLQkgKiBCZWNhdXNlIHBhZ2UgZmF1
bHQgY2FuIG9jY3VyIGluIGRpcl9lbWl0KCkgd2hlbiB0aGUgc2l6ZQotCSAqIG9mIGJ1ZmZlciBn
aXZlbiBmcm9tIHVzZXIgaXMgbGFyZ2VyIHRoYW4gb25lIHBhZ2Ugc2l6ZS4KLQkgKi8KIAltdXRl
eF91bmxvY2soJkVYRkFUX1NCKHNiKS0+c19sb2NrKTsKIAlpZiAoIWRpcl9lbWl0KGN0eCwgbmIt
Pmxmbiwgc3RybGVuKG5iLT5sZm4pLCBpbnVtLAogCQkJKGRlLmF0dHIgJiBBVFRSX1NVQkRJUikg
PyBEVF9ESVIgOiBEVF9SRUcpKQotCQlnb3RvIG91dF91bmxvY2tlZDsKLQltdXRleF9sb2NrKCZF
WEZBVF9TQihzYiktPnNfbG9jayk7CisJCWdvdG8gb3V0OwogCWN0eC0+cG9zID0gY3BvczsKIAln
b3RvIGdldF9uZXc7CiAKQEAgLTI5NCw5ICsyOTIsOCBAQCBzdGF0aWMgaW50IGV4ZmF0X2l0ZXJh
dGUoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBkaXJfY29udGV4dCAqY3R4KQogCWlmICghY3Bv
cyAmJiBmYWtlX29mZnNldCkKIAkJY3BvcyA9IElURVJfUE9TX0ZJTExFRF9ET1RTOwogCWN0eC0+
cG9zID0gY3BvczsKLXVubG9jazoKIAltdXRleF91bmxvY2soJkVYRkFUX1NCKHNiKS0+c19sb2Nr
KTsKLW91dF91bmxvY2tlZDoKK291dDoKIAkvKgogCSAqIFRvIGltcHJvdmUgcGVyZm9ybWFuY2Us
IGZyZWUgbmFtZWJ1ZiBhZnRlciB1bmxvY2sgc2JfbG9jay4KIAkgKiBJZiBuYW1lYnVmIGlzIG5v
dCBhbGxvY2F0ZWQsIHRoaXMgZnVuY3Rpb24gZG8gbm90aGluZwotLSAKMi4yNS4x
--0000000000000d4d7b060075cc28--

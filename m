Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87687D15F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjJTSpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJTSpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:45:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C962A112
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:45:18 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-507c5249d55so1578627e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1697827517; x=1698432317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZfFMOnzOWPDFZoMZUine3Kwx2BGR2wcwPk9fcWx+DPA=;
        b=L15wBn684gQRLC5JIbKGasf3N1ll18iVnrooVbnkwqU6SJ89TuSKz67/zlcH4jinmv
         vFtBN62AMRoEI5rvpezElB5U+33RMUU/Kz3pfbgGlPaq/zvF88CJrbNbdft3HP+IZjp1
         U8eKiByCtHitvlzvgUcEwI2r4xiURw7YcEEMeoy3MriDxvhZhs+T+oJmfMBYs3YaikrF
         xc1WHANk9VQ4hfFoRPHuBtWgFArKRlO6AL7NDoRYoMcl/adSNUShpbnOLQzVjtZiNKGa
         fFnUZQ09Xg6mcLHJvTeO50El9XBZOnusKVnedYYDfLvFigLUZHX65xihep32tbOpy4vr
         6Lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827517; x=1698432317;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfFMOnzOWPDFZoMZUine3Kwx2BGR2wcwPk9fcWx+DPA=;
        b=omRd7YckUX9OB1blKFfc8rnaDIUyXeDz/G7+AYdfyvGBp5VBUgqHOT7sPKZDYPJGZ3
         6s3up4/N38MDHZeU63xUxt1ZSRqPaDLd1Kv3qR+K/bOSbFupChU9Cny1MeeV5zsPga+b
         bZmTHT++9jJV0yPejYtUzmc4vStsPvyLV5l35cCDaIZz7FgsQq5S0k0AG/IBCxoWDXCS
         PvanioyybiranSUWhYYeUCAac52t+rw/2N03HIYvBi5gbIPq/4JYheZM2Hh8R9psu3Ah
         4fUWG7WolYUuSaMiEhOSy60Bs/6Ej0Au1C07shlH7nEbpwogu1fFtWMtgaoWURRPTSMU
         10Nw==
X-Gm-Message-State: AOJu0YyxE08OQl5wqSi8iIOkFyqaWLZvHqUfYc7vuANwvTAQ1zcl4tcO
        YKenlGfIk4eUjrSs45MYV4Hkh/cpzs7JY/JmifDRxQ==
X-Google-Smtp-Source: AGHT+IE5hZ1sKzwYuMwdSBO+vIOGwPbVFEcae0zzTmXEQmtV9ubV2XfshfdeCHWwUQnmfz7pTCIGDGe4fITdr3PoS58=
X-Received: by 2002:ac2:5a0a:0:b0:4fb:9f93:365f with SMTP id
 q10-20020ac25a0a000000b004fb9f93365fmr1881407lfn.38.1697827516928; Fri, 20
 Oct 2023 11:45:16 -0700 (PDT)
MIME-Version: 1.0
From:   Jan Henrik Weinstock <jan@mwa.re>
Date:   Fri, 20 Oct 2023 20:45:05 +0200
Message-ID: <CANi1PHhzk80HvwQbBM46gpJ6_AA_P6+m5Jo0Nuy_MAdA4C2BhQ@mail.gmail.com>
Subject: KVM exit to userspace on WFI
To:     maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Lukas_J=C3=BCnger?= <lukas@mwa.re>
Content-Type: multipart/mixed; boundary="00000000000009855e06082a46e7"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000009855e06082a46e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am looking for a way to have KVM_RUN exit back to userspace once the
vcpu encounters a WFI. It seems the kvm_run->request_interrupt_window
flag is currently ignored by arm64. So my solution thus far is to
patch kvm_handle_wfx in arch/arm64/kvm/handle_exit.c and return to
userspace with KVM_EXIT_IRQ_WINDOW_OPEN - working example attached.
Any chance to get this (or something similar) mainline?

--=20
Dr.-Ing. Jan Henrik Weinstock
Managing Director

MachineWare GmbH | www.machineware.de
H=C3=BChnermarkt 19, 52062 Aachen, Germany
Amtsgericht Aachen HRB25734

Gesch=C3=A4ftsf=C3=BChrung
Lukas J=C3=BCnger
Dr.-Ing. Jan Henrik Weinstock

--00000000000009855e06082a46e7
Content-Type: text/x-patch; charset="US-ASCII"; name="kvm.patch"
Content-Disposition: attachment; filename="kvm.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lnyy9nky0>
X-Attachment-Id: f_lnyy9nky0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva3ZtL2FybS5jIGIvYXJjaC9hcm02NC9rdm0vYXJtLmMK
aW5kZXggNTRkMjZmMTNmLi43YmU0MmUzZjEgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQva3ZtL2Fy
bS5jCisrKyBiL2FyY2gvYXJtNjQva3ZtL2FybS5jCkBAIC0yMTUsNiArMjE1LDcgQEAgaW50IGt2
bV92bV9pb2N0bF9jaGVja19leHRlbnNpb24oc3RydWN0IGt2bSAqa3ZtLCBsb25nIGV4dCkKIAlj
YXNlIEtWTV9DQVBfU0VUX0dVRVNUX0RFQlVHOgogCWNhc2UgS1ZNX0NBUF9WQ1BVX0FUVFJJQlVU
RVM6CiAJY2FzZSBLVk1fQ0FQX1BUUF9LVk06CisJY2FzZSBLVk1fQ0FQX0FSTV9XRlhfRVhJVDoK
IAkJciA9IDE7CiAJCWJyZWFrOwogCWNhc2UgS1ZNX0NBUF9TRVRfR1VFU1RfREVCVUcyOgpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9rdm0vaGFuZGxlX2V4aXQuYyBiL2FyY2gvYXJtNjQva3ZtL2hh
bmRsZV9leGl0LmMKaW5kZXggYTVhYjUyMTUwLi5kMDM4NmZhZWIgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtNjQva3ZtL2hhbmRsZV9leGl0LmMKKysrIGIvYXJjaC9hcm02NC9rdm0vaGFuZGxlX2V4aXQu
YwpAQCAtODgsNiArODgsMTEgQEAgc3RhdGljIGludCBoYW5kbGVfbm9fZnBzaW1kKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSkKICAqLwogc3RhdGljIGludCBrdm1faGFuZGxlX3dmeChzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUpCiB7CisJaWYgKHZjcHUtPnJ1bi0+cmVxdWVzdF9pbnRlcnJ1cHRfd2luZG93
KSB7CisJCXZjcHUtPnJ1bi0+ZXhpdF9yZWFzb24gPSBLVk1fRVhJVF9JUlFfV0lORE9XX09QRU47
CisJCXJldHVybiAwOworCX0KKwogCWlmIChrdm1fdmNwdV9nZXRfZXNyKHZjcHUpICYgRVNSX0VM
eF9XRnhfSVNTX1dGRSkgewogCQl0cmFjZV9rdm1fd2Z4X2FybTY0KCp2Y3B1X3BjKHZjcHUpLCB0
cnVlKTsKIAkJdmNwdS0+c3RhdC53ZmVfZXhpdF9zdGF0Kys7CmRpZmYgLS1naXQgYS9pbmNsdWRl
L3VhcGkvbGludXgva3ZtLmggYi9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgKaW5kZXggODNhMjE4
NWQ5Li4xMDczMjY5ZjIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9rdm0uaAorKysg
Yi9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgKQEAgLTExMjQsNiArMTEyNCw3IEBAIHN0cnVjdCBr
dm1fcHBjX3Jlc2l6ZV9ocHQgewogI2RlZmluZSBLVk1fQ0FQX1NZU19BVFRSSUJVVEVTIDIwOQog
I2RlZmluZSBLVk1fQ0FQX1MzOTBfTUVNX09QX0VYVEVOU0lPTiAyMTEKICNkZWZpbmUgS1ZNX0NB
UF9TMzkwX1pQQ0lfT1AgMjIxCisjZGVmaW5lIEtWTV9DQVBfQVJNX1dGWF9FWElUIDIyMgogCiAj
aWZkZWYgS1ZNX0NBUF9JUlFfUk9VVElORwogCg==
--00000000000009855e06082a46e7--

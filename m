Return-Path: <linux-kernel+bounces-103637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5C087C23D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAD51C21A01
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BECD74BEB;
	Thu, 14 Mar 2024 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Hnds6wRl"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A37443F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438681; cv=none; b=TRHmQYth1DMBmWstGb1wWTouhkZNSPiGVxvmQxF9wXQL9AuX0S/Yv1KRHrs0Y2fF+t29Krzp0sqZNnKgrjZTooVct0ONdigS5Ani+5XafywDWDEUfx46GG9XxjS8WYek7764+WR+eFBS21vspYVMhVgByyOu2oaMXsK1+99Ne5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438681; c=relaxed/simple;
	bh=kUVqfqBl6OrS8y6lo4ykNNWJdbCOGT3O6tMkIPe5R8I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A+By0XRDQYFCSoi4apVqMeVHtwgJqkAWTh5Kvp4Kkro2fiYidHfKJTiNdkOQFqNvS6fG5voN2TTUzWhKsg75NEfHttXlYEDOGJO5D47+DX9EfH18IAt7turylwsEk1cwxVOG3g5IgV0CSWU6eIJ3S6b3Fj4diH2AXaMXBAF8Cds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hnds6wRl; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so1812761276.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710438679; x=1711043479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yo6oS4AcC009MmPBD5DloFbZft+lin+hzANIRBSkUSA=;
        b=Hnds6wRlQB4t4EQaXM4q6swI2wP5CFzhHw5g9Uu3huXf/jZbWkrkkurKs7fI84edtj
         PnPo3EdUpFEJKFgFgED2Q3NcJLLVoCRs9tZsM2ZOUj85/FxW/E6VzX98Bgs3KYn/g0ZS
         HfYxXL07+bYwpU/1zRqJRVf4ssoGp6JDVdisuW/vCh8sRM+CCqbitB1JGdArz0eZh1Gi
         1uVb5VTWLZSziE0J+mF/C0VUW84fCdzZGs6s7nHZB6PJJIKY4miDdGJOexgE8stoE1Vd
         /XxIn/CNMi5EVl4DmvOx+k53F3ZYzvdkoLSYM1XK5XSSO3IF6l2Q00mK+T4SHg58A46U
         rE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710438679; x=1711043479;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yo6oS4AcC009MmPBD5DloFbZft+lin+hzANIRBSkUSA=;
        b=rUwpc1g2k6Mf12CyDETl71YvoDceFoLM9pN8JYex0DXLy8EkDkVyDAZ+CLYum8yR35
         z+KU2L81fzQwQwN69iezuIs3jTIkLnkeUN1rdoohthy3LbP7ulmURz1x+G7pb3SWN4t0
         wTmZWU8DcdrH5/2sXmR55j7FSxcPvtvyOC77z4R3QvmNfWSL3GAf8+UW+YOlZMcBqB17
         3+91aqAIoGz5D7ZA4NRTTNFXUW0yWnIy/ZM/7v1faVkndKKfaYWbj+5hWuAlKsYjiG4M
         yL+CaQdjLfQST5UDV25bGR9qlEPP960LQZThYAPeHegkSuhkc2Ebkf/wsdALxjHdmX6Y
         qVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd7PTC2kqeB+i3CdgXmKvzxbk9bo3XV2Q+hSgckNIsZm9dZRJKvnCITR9iMjWSbrC9c//WqT75ynYBLIomZGBRFgtPLBBIoAqPoxRy
X-Gm-Message-State: AOJu0YydojLD+xx7J15pF9BBXQcggMFZr9B0RWWFStf42ym9qzUIsh0/
	lFl8WVBGawlhXMtn5Hcw2QyPs4D2VC+O/mS7ylwL/GjtasaWkbPkxTSi0Q3297SFvTXmHcKubrJ
	C+g==
X-Google-Smtp-Source: AGHT+IHj12Fv5pkl+ktVSIACg0smeX5esnto6C7bfpPJvOND3/RpBJcke5Qg1JIRU0EQaPE2grYP8ghXkRc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1b85:b0:dc6:e1ed:bd1a with SMTP id
 ei5-20020a0569021b8500b00dc6e1edbd1amr582659ybb.2.1710438679190; Thu, 14 Mar
 2024 10:51:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 10:51:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314175116.2366301-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Fix __GUEST_ASSERT() format warnings in ARM's
 arch timer test
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Use %x instead of %lx when printing uint32_t variables to fix format
warnings in ARM's arch timer test.

aarch64/arch_timer.c: In function =E2=80=98guest_run_stage=E2=80=99:
aarch64/arch_timer.c:138:33: warning: format =E2=80=98%lx=E2=80=99 expects =
argument of type =E2=80=98long unsigned int=E2=80=99,
                             but argument 6 has type =E2=80=98uint32_t=E2=
=80=99 {aka =E2=80=98unsigned int=E2=80=99} [-Wformat=3D]
  138 |                                 "config_iter + 1 =3D 0x%lx, irq_ite=
r =3D 0x%lx.\n"
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
.....
  141 |                                 config_iter + 1, irq_iter);
      |                                 ~~~~~~~~~~~~~~~
      |                                             |
      |                                             uint32_t {aka unsigned =
int}

Fixes: d1dafd065a23 ("KVM: arm64: selftests: Enable tuning of error margin =
in arch_timer test")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

2024 Whack-a-Mole Champion.

Note, this is based on kvm/queue and probably won't apply to your tree as
the buggy commit went in via the RISC-V pull request.

 tools/testing/selftests/kvm/aarch64/arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testi=
ng/selftests/kvm/aarch64/arch_timer.c
index ddba2c2fb5de..93100b3f1312 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -135,7 +135,7 @@ static void guest_run_stage(struct test_vcpu_shared_dat=
a *shared_data,
=20
 		irq_iter =3D READ_ONCE(shared_data->nr_iter);
 		__GUEST_ASSERT(config_iter + 1 =3D=3D irq_iter,
-				"config_iter + 1 =3D 0x%lx, irq_iter =3D 0x%lx.\n"
+				"config_iter + 1 =3D 0x%x, irq_iter =3D 0x%x.\n"
 				"  Guest timer interrupt was not trigged within the specified\n"
 				"  interval, try to increase the error margin by [-e] option.\n",
 				config_iter + 1, irq_iter);

base-commit: e9a2bba476c8332ed547fce485c158d03b0b9659
--=20
2.44.0.291.gc1ea87d7ee-goog



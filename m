Return-Path: <linux-kernel+bounces-106735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021D687F2C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9724AB22002
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2969B59B71;
	Mon, 18 Mar 2024 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hs1/DWul"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393C59B5E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799286; cv=none; b=pF6I7wNofkzaEbN8vH+FBuihH76C9Vev0MVC3tOrd6QII+2l90g1CrtgAGRVCuPrhJbUACUCT6xP2XqjF4RzMgmI/j0Wz362J6JJ2o321vMCt4IZ10nwQ54bLbMnagb/zp2PciW6Vtdisz2lKMfPl/L8nHMYZOjLMlIZgaGmhXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799286; c=relaxed/simple;
	bh=7EdK8NAm1pxBaAUpg57HenZat5hfoEYA3UgL0477Yf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2n0byUQN408nLvqbZ+E57APquR4poN7N0rZZoXNyWK283WS9QndPzFDzwPdR9nnomxjwl4Y2TzzDtaV5265yWQIfVz/8dizOIUZjOv4byFm/IsxzRbP9pTAH4OUIzmVzo99tJit/m1Jw9/48CH1J9/AEfccMflTT7aMq2eiWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hs1/DWul; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710799283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfZZXfR1kSbJWAilZOdtsf7QJvf/A9npXvRYhQ2sZZc=;
	b=hs1/DWulG93uSw5BDMUjpNFSeaPOzr8ce+G3iJgnWbpUSJMx+8MMBskmrZSXkmtS2Wvq9V
	hHjb5KqnkK3p79jOjaM5FZz3eUNGMRUSa10s9NzcJ3aPFZ7wCA57jAlTb6gUUybMSPgXa2
	fNO7p2nZvL11LGcDJcKKhp/K2EODG0g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-dNJXvZVnOHGKb8PqqwI1Ig-1; Mon, 18 Mar 2024 18:01:22 -0400
X-MC-Unique: dNJXvZVnOHGKb8PqqwI1Ig-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e435a606aso26011745e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710799281; x=1711404081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfZZXfR1kSbJWAilZOdtsf7QJvf/A9npXvRYhQ2sZZc=;
        b=wq3h/pBjcq9liVRlrrW1LOB6YtvEuFGvNXNzlnCGrZVt9jWEX6bHgWlS8xuTd74Nnh
         cLwqfEa9kDOpV6emJEAZRArcaADx6PkKLZhceYpT29SJuIWlWhZjen/9Fi1Vl2JQktQ5
         kGax7Ycraqdg+RgaXGGP8sMkn9ACLYtdPAO+VPWoeITOr+cojntVO6Gh5oZauimHjYS/
         HpTZzdetM28OdqT6LoEu3aypnNZ2zVV9hcqb+XOe9AFnkE1n4ddbzHrTbimCPbg3aaX6
         XYqD8LlER0xOaaifvSccwIKzfXmmvU3u+NOVCd6fjcPmaRbj8WbDtcytbvNEtFmh/3L1
         qz7A==
X-Gm-Message-State: AOJu0YyDUOAyz95zlhHvoJmVmIdvfjO9Oc5INqJ5PgrLTDrF8m43jz9y
	5eo2JbyRP0v7OAVdMfKZmXGYNMjXedlT/5iAfIi12pIpNSi/RWulwnNoMcN/9X1C4co+/J1iDF6
	Q2IVBMSx3Y2m1+5uSckX1QI17DB/5k8Z2mH2U72Iul7NL+kZLW6nsQx+qpW7NAmILILUaS+1VrX
	VLInSXza8C7rdXwvWkYJnz5rOTQVA4lKccq0+c
X-Received: by 2002:a05:600c:314e:b0:413:ee58:db7e with SMTP id h14-20020a05600c314e00b00413ee58db7emr559875wmo.3.1710799280976;
        Mon, 18 Mar 2024 15:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPBtYKJBfOb3aBQLqb3AHBFvSowntgdfM4R7ayXLVxzEAxtnXjLmVXKjhj6EG9VnTPbKNmqcKmxN5CCTPdHHE=
X-Received: by 2002:a05:600c:314e:b0:413:ee58:db7e with SMTP id
 h14-20020a05600c314e00b00413ee58db7emr559860wmo.3.1710799280659; Mon, 18 Mar
 2024 15:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226190344.787149-1-pbonzini@redhat.com> <20240226190344.787149-11-pbonzini@redhat.com>
 <20240314024952.w6n6ol5hjzqayn2g@amd.com>
In-Reply-To: <20240314024952.w6n6ol5hjzqayn2g@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Mar 2024 23:01:09 +0100
Message-ID: <CABgObfYpGUBYj94PSNkYsa_NDGVE=NOJnjHSZoE5d7sSGmVfQA@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] KVM: x86: add fields to struct kvm_arch for CoCo features
To: Michael Roth <michael.roth@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com, 
	aik@amd.com, pankaj.gupta@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 3:50=E2=80=AFAM Michael Roth <michael.roth@amd.com>=
 wrote:
> I've been trying to get SNP running on top of these patches and hit and
> issue with these due to fpstate_set_confidential() being done during
> svm_vcpu_create(), so when QEMU tries to sync FPU state prior to calling
> SNP_LAUNCH_FINISH it errors out. I think the same would happen with
> SEV-ES as well.
>
> Maybe fpstate_set_confidential() should be relocated to SEV_LAUNCH_FINISH
> site as part of these patches?

To SEV_LAUNCH_UPDATE_VMSA, I think, since that's where the last
opportunity lies to sync the contents of struct kvm_vcpu.

> Also, do you happen to have a pointer to the WIP QEMU patches? Happy to
> help with posting/testing those since we'll need similar for
> SEV_INIT2-based SNP patches.

Pushed to https://gitlab.com/bonzini/qemu, branch sevinit2. There is a
hackish commit "runstate: skip initial CPU reset if reset is not
actually possible" that needs some auditing, because I'd like to
replace

-    cpu_synchronize_all_post_reset();
+    if (cpus_are_resettable()) {
+        cpu_synchronize_all_post_reset();
+    } else {
+        /* Assume that cpu_synchronize_all_post_init() was enough. */
+        assert(runstate_check(RUN_STATE_PRELAUNCH));
+    }

with

-    cpu_synchronize_all_post_reset();
+    /*
+     * cpu_synchronize_all_post_init() has already happened if the VM hasn=
't
+     * launched.
+     */
+    if (!runstate_check(RUN_STATE_PRELAUNCH)) {
+        cpu_synchronize_all_post_reset();
+    }

Paolo



Return-Path: <linux-kernel+bounces-67006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F628564B3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E62286EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50683131749;
	Thu, 15 Feb 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NA0Us0bD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96112B144
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004698; cv=none; b=XzVMXXBzqD/FyQQdamJq4kneLJzlts4/LksLC4wA1Naa5X9oi2adBahn/UMwRYvvonZlG2AHM7s+fV0A/8ESnzXh+nS6nX3QEKZyyTF8K5ZA5QPEWG1aXew25MNunnu4Z59yYWJzZGMykp6YtyFUYE+aY2hqughWsHsk1pIiiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004698; c=relaxed/simple;
	bh=ov3VmXzDZCCLW/BZ7JwwFgcYShbcwFfP+oLLIIxjH7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3eVgcUH5qyy0hZOdlOlZ7xRLfK2VbJezXrJMa8mcpX4K5Ogrz46b/AVN/CNOKqeII/S5D4p205ABsR18Ry6tngU28WIwg1LD6Ep/tDwLL4/AYJgm5zFqMwowjSEF40Bn5tDzByhqCBM+aF6PhLpbjwqzgqh+NC1a8YIrIoIh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NA0Us0bD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708004695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=83HKxgolObBJ7E24ueW7SJzyGPOvjgws+//Qd73dSDc=;
	b=NA0Us0bDXLn1QhRcAXuxBvVueDvMDWGTIT/lMGkN4ZcvfnY46CKw/QLALXC09cy3T6bMfc
	geP2ArfGKKvUDW+TY9Xtkwxucnn/uJoEZDtfQHHoXGSu5GtsIcZG1NjYITg+jUkAFPa0U8
	Rkthm/ItfGE/fUw025BFiajBjiPzbY0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-CGIE52pzO4Oc9DVCll6Rvg-1; Thu, 15 Feb 2024 08:44:49 -0500
X-MC-Unique: CGIE52pzO4Oc9DVCll6Rvg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51197d1fcc2so673692e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708004688; x=1708609488;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83HKxgolObBJ7E24ueW7SJzyGPOvjgws+//Qd73dSDc=;
        b=Dy34E3/5LBQOKhN8QXML+91xqJ4QFOEEF0cfEWCffi8PsawiqMSTkTVbCeNoOENI/E
         YN+kQ4AQcZNEcrIiervCSI8xePqzeTZUlYCKGprLgTBIAcLKLe+2sBOhxfaJR3NEPNT6
         SuufQvyacALuLywTj1Iw2ewE9eX9nSFhuGoCHz6KWtfJT64WOTxC/sV9tbtC/0p3YNoE
         pBqeeWyIyGQ3dBIpZNhwnY5ePwK+khStn1GUdjPR8pzc7W0T0LYGK8Db+YiWq8u7wkkz
         qNiVNnetaAxPy9OVWw4kIMPr4A9VPHvwsbB3VD/IIWZBADmEX+9lNorOiYJX2fJvrguV
         QJjQ==
X-Gm-Message-State: AOJu0Ywy6PXeF5RJ07GqWdQr2otkDcTz5+IytjvMoA7Yy1pf0YsadK6o
	sUzYSMllbhgbcx6rh/1J5yOQpHWTNDrD4/fjYhBge52/QmS+0Q5Dl7nkjDVlXFuaXrliBHibwJb
	PxDP0YJL8voO8U4o3tKeXcjMGxar5WqyMS2rkueesp1IjNGIOuXGif6cAvpJ8uA==
X-Received: by 2002:ac2:4114:0:b0:511:a4c9:a00f with SMTP id b20-20020ac24114000000b00511a4c9a00fmr1486901lfi.30.1708004688528;
        Thu, 15 Feb 2024 05:44:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPI3vbmfiuxEL4pGO+gqwOvh7J2LXJVrdWmmL5CGMPnxEgXIhYIDt7JmCQTuhRdDmQH+mpXg==
X-Received: by 2002:ac2:4114:0:b0:511:a4c9:a00f with SMTP id b20-20020ac24114000000b00511a4c9a00fmr1486889lfi.30.1708004688064;
        Thu, 15 Feb 2024 05:44:48 -0800 (PST)
Received: from [192.168.1.174] ([151.64.123.201])
        by smtp.googlemail.com with ESMTPSA id r11-20020a056402018b00b00563c3192f56sm215809edv.5.2024.02.15.05.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:44:47 -0800 (PST)
Message-ID: <ddabdb1f-9b33-4576-a47f-f19fe5ca6b7e@redhat.com>
Date: Thu, 15 Feb 2024 14:44:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] KVM: SEV: introduce KVM_SEV_INIT2 operation
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 aik@amd.com, isaku.yamahata@intel.com
References: <20240209183743.22030-1-pbonzini@redhat.com>
 <20240209183743.22030-10-pbonzini@redhat.com>
 <20240215013415.bmlsmt7tmebmgtkh@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240215013415.bmlsmt7tmebmgtkh@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 02:34, Michael Roth wrote:
>> +        struct struct kvm_sev_init {
> Missing the vm_type param here.

It can go away in the struct actually.  Also, "struct struct".

>> +If the ``KVM_X86_SEV_VMSA_FEATURES`` attribute does not exist, the hypervisor only
>> +supports KVM_SEV_INIT and KVM_SEV_ES_INIT.  In that case the set of VMSA features is
>> +undefined.
> 
> It's hard to imagine userspace implementation support for querying
> KVM_X86_SEV_VMSA_FEATURES but still insisting on KVM_SEV_INIT.

.. except for backwards compatibility with old kernels.  For example, 
the VMM could first invoke HAS_DEVICE_ATTR, and then fall back to 
KVM_SEV_INIT after checking that the user did not explicitly request or 
forbid one or more VMSA features.

> Maybe it
> would be better to just lock in that VMSA_FEATURES at what is currently
> supported: DEBUG_SWAP=on/off depending on the kvm_amd module param, and
> then for all other features require opt-in via KVM_SEV_INIT2, and then
> bake that into the documentation. That way way they could still reference
> this documentation to properly calculate measurements for older/existing
> VMM implementations.

Thinking more about it, I think all features including debug_swap should 
be disabled with the old SEV_INIT/SEV_ES_INIT.  Because the features 
need to match between the VMM and the measurement calculation, they need 
to be added explicitly on e.g. the QEMU command line.

Paolo



Return-Path: <linux-kernel+bounces-26311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B882DE60
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E9D1C21CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D529618021;
	Mon, 15 Jan 2024 17:21:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C552A17C7B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD97D2F4;
	Mon, 15 Jan 2024 09:22:09 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 709273F5A1;
	Mon, 15 Jan 2024 09:21:21 -0800 (PST)
Message-ID: <67b15918-e9d3-97ea-65ca-985b5ddb3f88@arm.com>
Date: Mon, 15 Jan 2024 17:21:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] KVM: arm64: Add missing ERX*_EL1 registers
Content-Language: en-GB
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Cc: Ruidong Tian <tianruidong@linux.alibaba.com>, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com,
 will@kernel.org
References: <20240110075739.8291-1-tianruidong@linux.alibaba.com>
 <867ckh9y7l.wl-maz@kernel.org> <ZaVFmtKbtCJtaAAu@linux.dev>
From: James Morse <james.morse@arm.com>
In-Reply-To: <ZaVFmtKbtCJtaAAu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 15/01/2024 14:47, Oliver Upton wrote:
> On Wed, Jan 10, 2024 at 12:20:30PM +0000, Marc Zyngier wrote:
>> If my reading of the ARM ARM is correct, these registers only exist if
>> FEAT_RASv1p1 is implemented. Which means that we shouldn't handle
>> those as RAZ/WI unconditionally, but instead check for what we
>> advertise to the guest and handle it accordingly.
> 
> Can we go a step further and just stop advertising RAS to guests? I don't
> expect VMs to gain much from our RAZ/WI implementation.

These CPU registers would describe the error in a kernel-first setup, but firmware-first
has its own in-memory way of doing that.

The CPU features indicates the IESB feature and ESB-instruction exist to fence errors, and
that the CPU uses the ESR_ELx.{S,A}ET bits to describe the CPU state after an error. These
are all useful as part of the notification of an error, be that kernel-first or
firmware-first.

When its supported by the hardware, the VMM can inject an asynchronous external abort
using KVM_GET_VCPU_EVENTS - otherwise the ESR_ELx.ISS bits are all imp-def, meaning all
errors are catastrophic.

Doing this would skip save/restore of VDISR_EL2, is there any other reason to do it?


> Conditional
> RAZ/WI would still be helpful in this case for migrated VMs that have
> 'seen' the feature.


Thanks,

James


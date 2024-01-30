Return-Path: <linux-kernel+bounces-45339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B8842EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16403287A18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E798E78B6C;
	Tue, 30 Jan 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS5LsMnj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187678B52;
	Tue, 30 Jan 2024 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706650850; cv=none; b=TJo3QyfBWGfV8E1jJGoItEA2IiyAqBgzJgqvL0Zv6E61UILTLyr0WKU/me4yK9Pt0UubbBl87N9yvpXLNJImEyWfaeYDLE2+h4wkb9vcFCW5mLNfqesF8fzjdec0LYzvBsumMw3AZdjR6KHBrk1Z/THM72TcFqpGCrY5C4B797w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706650850; c=relaxed/simple;
	bh=pnAGIah8tDwiGmWDjULK1v1d3MLSt9GYUDCogaBsWHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaDucR3yaUa70qNOj1zYTmb4/MV07Z5UEaUU9ugHf/xdoUvjr6xa8/JT1YGLgXpfpGzRpOFt3H+nBFb39l5az6/f5M7G/rPrH8/vPMnWRlFbyLY8iyjqjV2hCNo6DrFFwZstAPZPiG3wq0lmUUIUeVl66HA8hAJS6BD6W+ECbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS5LsMnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7A1C433C7;
	Tue, 30 Jan 2024 21:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706650849;
	bh=pnAGIah8tDwiGmWDjULK1v1d3MLSt9GYUDCogaBsWHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PS5LsMnjn7Mbhs/Ij/7IDcnvl7UE3Kc9Cd4jIBG41zOwUg5pRGa8B/NQym6H4+J53
	 zzTfwxKRGuOtwlBEm8UhSzwuEr1bbZmt/S5IcXEMAafUoliin1pyE6PH0jTH/KB3Ui
	 nO3pvM6w0m6sKxodc2DogEdVlNta7XMT+zj0V4hoY+60mItBtiX6YOrmeccXs63c3m
	 Pk29OiSeYXfO5yQhNrign4ozByI9vlJtxiakBeyec2hJ53DULGUE/VYtKokpgysX27
	 djt8hj1WwehzMmQo4b2joiZ6fMajmpRNUDCHySxyaQjzQ8vYurH6iZZcU23i60PPP9
	 QsVqPZfGNC2Wg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rUvqZ-00GOhj-Hv;
	Tue, 30 Jan 2024 21:40:47 +0000
From: Marc Zyngier <maz@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Sebastian Ene <sebastianene@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>
Cc: kvmarm@lists.linux.dev,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] KVM: arm64: Fix circular locking dependency
Date: Tue, 30 Jan 2024 21:40:43 +0000
Message-Id: <170665083753.694736.5736115942255110234.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124091027.1477174-2-sebastianene@google.com>
References: <20240124091027.1477174-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, oliver.upton@linux.dev, sebastianene@google.com, catalin.marinas@arm.com, yuzenghui@huawei.com, will@kernel.org, james.morse@arm.com, kvmarm@lists.linux.dev, kernel-team@android.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 24 Jan 2024 09:10:28 +0000, Sebastian Ene wrote:
> The rule inside kvm enforces that the vcpu->mutex is taken *inside*
> kvm->lock. The rule is violated by the pkvm_create_hyp_vm() which acquires
> the kvm->lock while already holding the vcpu->mutex lock from
> kvm_vcpu_ioctl(). Avoid the circular locking dependency altogether by
> protecting the hyp vm handle with the config_lock, much like we already
> do for other forms of VM-scoped data.

Applied to fixes, thanks!

[1/1] KVM: arm64: Fix circular locking dependency
      commit: 10c02aad111df02088d1a81792a709f6a7eca6cc

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.




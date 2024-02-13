Return-Path: <linux-kernel+bounces-64160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94F853AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F83C1C21BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067375FF0A;
	Tue, 13 Feb 2024 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnUA/PQA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CCB56768;
	Tue, 13 Feb 2024 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852323; cv=none; b=b0eBMKi2fpK4MVl/dlrIBA1pQpToiGcjmGfr/ixdPlePxEO1Oeo6iI3f74Uhs3tiqMjrzrzxKcvgjQLQbSIY4DzQ188b0cOhwG3xoTkNUfnV2NhUze3/HOIzfL+hVTQnIM7JC3gJ8dxiOzg4QBNLck2iXXHCWTOv5ZUdJhJ1hv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852323; c=relaxed/simple;
	bh=I6hO5jlwBaKJFc+VKnC3tf7xGWq+cLtrlW3tHXiWBho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSrx26smceRVFm/IhjmuCf0gd3OL8BFRqd2BC/K08tuqAfJgVE/faQEH7g9QeXCKeaUYeBHZlTRee0C4yOPPzK7YcAWWs45SYElDOQjNhQ0K2ZxpW5AqFiNgJ+0AVQ9IKYxu8ED9dcaJReS3BiQDpU1n9Y83TrbOWK993ey8DXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnUA/PQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8B7C433C7;
	Tue, 13 Feb 2024 19:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707852322;
	bh=I6hO5jlwBaKJFc+VKnC3tf7xGWq+cLtrlW3tHXiWBho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PnUA/PQAwLP7ry+1TEQd4Dzy+U76NeX7ehNECyNf8BUEVbl7sUR6aLeKiygsvASmM
	 yBW/mLpsuPR3cq4DfEBWqsmfQ1v7/UqO52m2WIM5MFbhCaXThPYTAR6GbRxO4QbZVx
	 QdDDst/fWw3i6IRA+KiGIMWCJnkLW/cduT1oNC3/asc3CIcA9wyuSds2FTv165JLA/
	 aI/PAB8QZM68FSc33cVNCKMvtkHGsp3rIzwiqcbbYlGTeGVyRaBfOO1zLOyxQj+axX
	 soVuJfXrFgr4/TGuQzyiBkmRSjN+N7xI3CG4lWcHV383Noau/FAJ+CDXNRmVsfKq2g
	 ybDI1+le7luqw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rZyPA-002tNf-Hf;
	Tue, 13 Feb 2024 19:25:20 +0000
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>,
	kvmarm@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org,
	Ricardo Koller <ricarkol@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] KVM: arm64: Fix double-free following kvm_pgtable_stage2_free_unlinked()
Date: Tue, 13 Feb 2024 19:25:16 +0000
Message-Id: <170785230656.2847941.2376736166184489545.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212193052.27765-1-will@kernel.org>
References: <20240212193052.27765-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: will@kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, ricarkol@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 12 Feb 2024 19:30:52 +0000, Will Deacon wrote:
> kvm_pgtable_stage2_free_unlinked() does the final put_page() on the
> root page of the sub-tree before returning, so remove the additional
> put_page() invocations in the callers.

Applied to fixes, thanks!

[1/1] KVM: arm64: Fix double-free following kvm_pgtable_stage2_free_unlinked()
      commit: c60d847be7b8e69e419e02a2b3d19c2842a3c35d

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.




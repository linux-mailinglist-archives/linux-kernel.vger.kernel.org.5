Return-Path: <linux-kernel+bounces-138327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBD789EFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7301C22525
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC60159211;
	Wed, 10 Apr 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c10OJVwq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A02744D;
	Wed, 10 Apr 2024 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745048; cv=none; b=UIv5FtFmK8ij+aRLuJIb9hiLShll3jF01cybL6JXVJWH501f7KOG3emfiGMU/P+gNE39QVF64Xe78q7e3z+gD0LRlki8sjhu3DTbHK/JQu69HWembFhV26PBYLcymZp5zkGAUEi1zwIyAWq/CM7mIUqJC0AWhxt1EAkqk7F1K50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745048; c=relaxed/simple;
	bh=PFOYzkTQaz4RIV29s8crIVArTeI+klJddc4BaSfF6jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkS26NpTukInXnC/KEqCsgjtgmSIbUqAf5oVPTVZAyhDsGwbgRcEJNoKLP1e+VlFWj78nfhiEhyldxrxYTKHSgZEM+4lXLHJhroaxXvux7bHyryVOK5LM45wCqP+hKsLnroboUSup8LnU5ED7loGmKLhdbMvhC9WUwVmcNYqbCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c10OJVwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725A9C433F1;
	Wed, 10 Apr 2024 10:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712745048;
	bh=PFOYzkTQaz4RIV29s8crIVArTeI+klJddc4BaSfF6jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c10OJVwqruArl5g5dCIgIlZ3UQywtIqmha4t4djM5xAnA40tOoewe49ZDfgnbs38h
	 kDjnmrcSFdYLitqgQsypKWVoUmWkDcXatkwBPlRgrTu6NvrT67UoxwtkRkKX1Y0pfJ
	 Dv8WAyqZxbAAD5rnFwpGkX6xcLah7Ylzn0RqYthYchZ51lDX7xdbDjs/GxU3izIIpE
	 +VSq7LX7heBJlX3KtXnAyQksjEqG6w68dA+JOgWYYz/O1cGRCAy4n3zcELfyYMEp4p
	 kT/GiIQg5C1LiGKQ6M8jPFLf7nFfqoCHRO/c+Zr895CnKGEiv18IaCub+OvG4MR87f
	 PpysPvsBYjKPQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Yangyu Chen <cyy@cyyself.name>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH RESEND v8 0/6] riscv: add initial support for Canaan Kendryte K230
Date: Wed, 10 Apr 2024 11:30:25 +0100
Message-ID: <20240410-unwoven-march-299a9499f5f4@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=g1jnmXwY+mRbkP1JjfYfibR7YG/ZdsVyF8SLWs6lEX0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGliWY7L232dpH74pq6L8PmpOyv0rfqW0Nz7DkK6ErZKi soGl7d2lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCJmKowMm6clMFUtl8+J0Rbv 1PZMy9sh+WNTGH9Jk9VBTqklmxheMfwVrewWtTDnvnTFcO2UWyI7hav2M4pdnCRn5xH9WjBVjoM LAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 08 Apr 2024 00:26:58 +0800, Yangyu Chen wrote:
> K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add initial
> support for it to allow more people to participate in building drivers
> to mainline for it.
> 
> This kernel has been tested upon factory SDK [1] with
> k230_evb_only_linux_defconfig and patched mainline opensbi [2] to skip
> locked pmp and successfully booted to busybox on initrd with this log [3].
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/6] dt-bindings: riscv: Add T-HEAD C908 compatible
      https://git.kernel.org/conor/c/64cbc46bb854
[2/6] dt-bindings: add Canaan K230 boards compatible strings
      https://git.kernel.org/conor/c/b065da13ea9c
[3/6] dt-bindings: timer: Add Canaan K230 CLINT
      https://git.kernel.org/conor/c/b3ae796d0a4f
[4/6] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
      https://git.kernel.org/conor/c/db54fda11b13
[5/6] riscv: dts: add initial canmv-k230 and k230-evb dts
      https://git.kernel.org/conor/c/5db2c4dc413e


6/6 intentionally missing, it goes on another branch.

Thanks,
Conor.


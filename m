Return-Path: <linux-kernel+bounces-2397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF4815C97
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 00:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80FBAB233C7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BD5374D8;
	Sat, 16 Dec 2023 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDU/CcYJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F83714E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 23:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDECC433C7;
	Sat, 16 Dec 2023 23:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702770197;
	bh=XxA10n9pk/GAfkmMK38vgv4ImRz2CJHlcGKcI4SdK6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDU/CcYJHwhsxhBi9Bnr7hL5oZPsJz6vykA+zT3SXR9l/QbPD7NMP38WiqLbF816C
	 qI+R8CCH0JFRWGedgo0jHBt0zXPSRzeHGckzoCMvz//YmuZUkQtOFeS8V2XEq7QK36
	 q1K6eFJTdU7aH3gyypXpdfzG6DmavkBaVejXcmH3ea40/XM57oZ1RV1Ud+Qx4FWRBJ
	 gUHacKMpG8+m8LNMxPTuj5bflOfAxGxoxzkQzXwxRIlRLQ/yH9ZwkW0THj5B+fawkt
	 gjw7vqorylnF872QtDjdEnbKYkTkrrHDDLp2PTFu4qdPSX2ytMn9f4+ri/oTbBDklt
	 FB5HXdhtIQfyg==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] riscv: errata: Make ERRATA_STARFIVE_JH7100 depend on !DMA_DIRECT_REMAP
Date: Sat, 16 Dec 2023 23:43:02 +0000
Message-Id: <20231216-banknote-sanction-4643975710fb@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215190909.3722757-1-emil.renner.berthing@canonical.com>
References: <20231215190909.3722757-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=551; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=o6Dp/7qRhGoRQyRb//hF/Y31njOm+E+ACzcMesgkTSU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKl1ZiyZrzgMPourz3q7qbcuL2JCy5vVRcE738V8vrrtS sxVr3tJHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIaU1GhuurfN1EUnizMn4E LTCa8VdMoUpreV/V1hnKOUfTfXVPfGL4n7zvHe/8nXbqNf87GVLXvXt6JFYzOyPcsW3+szss16/ e5wcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 15 Dec 2023 20:09:09 +0100, Emil Renner Berthing wrote:
> Similar to the Renesas RZ/Five[1] the JH7100 SoC needs the non-portable
> CONFIG_DMA_GLOBAL_POOL enabled which is incompatible with DMA_DIRECT_REMAP
> selected by RISCV_ISA_ZICBOM.
> 
> [1]: commit 31b2daea0764 ("soc: renesas: Make RZ/Five depend on !DMA_DIRECT_REMAP")
> 
> 
> [...]

Applied to riscv-cache-for-next, thanks!

[1/1] riscv: errata: Make ERRATA_STARFIVE_JH7100 depend on !DMA_DIRECT_REMAP
      https://git.kernel.org/conor/c/9a9e8d8d2b6e

Thanks,
Conor.


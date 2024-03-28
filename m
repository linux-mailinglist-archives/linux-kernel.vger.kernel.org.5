Return-Path: <linux-kernel+bounces-123786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61B9890DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650251F23CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A46A3A1BA;
	Thu, 28 Mar 2024 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ljof7OKC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6328DCA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665954; cv=none; b=QJpgOOhzqhFnmcv4mN8QlvISySsAGi8xOFmZMWuMjLv2LCiuj1VmkpBlbj7g8n3BqI0JX4vZ4Rl7qRSILS4t/sXjBDymAcLOkeIB2sq227ekP6yHITgAu1azoifqGILSVf+HscMaea04sGD07BTpZKK5Pu9v92RRXfH0Z5LjLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665954; c=relaxed/simple;
	bh=W1e7ay70S0bGDbL9O//v9FziMstI7A/WkxYpH53hCK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBVnv1P4z/t5QrmRdOUEkFM8NvzfZIKoBqz7lZjFqRshj+XMW7XSkDDqpmfhzS2h1zwD2SGh3z9wvqlqG14+Nza5BKNLZdSbDaCxmJq0p3ya7mittSvtOclu5ZRwItMLjS115rnGbzQluXtG399sEV4J1D0K4z0v3qUjf+i6F04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ljof7OKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB078C433F1;
	Thu, 28 Mar 2024 22:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711665953;
	bh=W1e7ay70S0bGDbL9O//v9FziMstI7A/WkxYpH53hCK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ljof7OKCozUwgL++K/IYKfu+qE0IRqfUh60p53OfvZMETuD5zvkA5KIBxKHY8MOi3
	 eon320X/S1ZUu7nDhy3D0wad9HaY9d5DCv9dHqoS6kDewihmbBGcVYlN4GzhWjWk+p
	 vmMvLNxOavTDurLKXhOj5Ifb1f0L4qRpv/upQCW6NdK3fNX4XIV+jCeMnUFQmmOh8T
	 rysuPq4wp61ppjHREvMvdVxv+5jjddIPd45F4HbmqtewhltVIzjBLP0+9fU1oqlNbf
	 RAi6LjUzMPVG45wAMM0E2eu8ar3cMqC3LsbmCks1YxrkYEMBZG3DuvzpJUMABzqoRe
	 7d4v6dBODq4jw==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] cache: sifive_ccache: Partially convert to a platform driver
Date: Thu, 28 Mar 2024 22:44:10 +0000
Message-ID: <20240328-humongous-amaretto-bc4564097bd2@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327054537.424980-1-samuel.holland@sifive.com>
References: <20240327054537.424980-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=588; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=WCT5UiUI9Iq6C/Nwi2p53WJDPcmeVV5PAclYbFknN+I=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmsn665TTotf227YtuJaWYr5zFwFkZ+NFKt9D+mmRd+8 fDFC4z3OkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCR4p8M/4zv2bucFTaUMGcT 224q/THpZeL1RYrv7ScG/pkyJbLk3xSGf0YBXxSUV+wJrCl2/bH/8dkzHgsOWyxbs47n3muus1d sO/kA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 26 Mar 2024 22:45:24 -0700, Samuel Holland wrote:
> Commit 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a
> platform driver") broke ccache initialization because the PLIC IRQ
> domain is no longer available during an arch_initcall:
> 
>   [    0.087229] irq: no irq domain found for interrupt-controller@c000000 !
>   [    0.087255] CCACHE: Could not request IRQ 0
> 
> [...]

Applied to riscv-soc-fixes, thanks for doing this Samuel.

[1/1] cache: sifive_ccache: Partially convert to a platform driver
      https://git.kernel.org/conor/c/c90847bcbfb6

Thanks,
Conor.


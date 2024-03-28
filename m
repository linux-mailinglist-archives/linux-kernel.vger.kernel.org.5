Return-Path: <linux-kernel+bounces-122763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F51188FCCE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E247B1F297DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5790B7D07C;
	Thu, 28 Mar 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRmKzIRW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0A7C090;
	Thu, 28 Mar 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621241; cv=none; b=Q9m9VFHuyOnmYHyuIciFh6K0QgZ89QttzfbqG3bjFajBNbOU2dYMakmC+VIDnibrGwElsR3VFqtzX69NdZ0hmdBgkHCoU2e4k0hOGrXUCCQkpbwioViojjeuI+QQ+cVa2pOuQLuBz3sDzWzzZNvPvYSVR0EmaeTWdAi8dSHncRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621241; c=relaxed/simple;
	bh=fWlJ01QF5Xi33HgqI7U4KP63mnAjujPsD7CIjtecFAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzafSjCcJXZEpR6OZAVkQe+z5/KbnKhu+ScQuI4t4XfOPM8amzFfatPYl1kFAKCZCUZYgT6UtJmY8Cd0/lPC668HoQ8UT6GdNMQyFsEXEeDAzTHGWdiJIdQ0ME4XvEdSJ5g0Y4fPZHhzhPbJxaOImV39tigv9Hz7moU31IxeLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRmKzIRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE85C433C7;
	Thu, 28 Mar 2024 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711621241;
	bh=fWlJ01QF5Xi33HgqI7U4KP63mnAjujPsD7CIjtecFAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IRmKzIRWnByfWLhp7RMlDfqPDmwN1nCrz/1T+9IJ+gYuEFyfpddAuHMKb9RZ1KJJs
	 G7IpM0JBSDz5uenOCl5HHhPse3wfbnayY0b/EZZO4UtxrhLxkrqY/3cqHxKQdM6L3Q
	 s5Fz5L4p6dIDOWX2yjSo+LsR15PFlIHK+D23n0IwTcn+wHINiVDkcCsmQVp/1Myz6Z
	 R0Jmau0wn8SKIZi669ImftysH390bFxfoPmg+ojmyMti69n2l02LAVP6HePGO9Emz5
	 uM+riMv6kkAb91uLuZgVtf0LBhUgQbasUVc98b35ji9dM/kc5k/PgRATjTyX5sz3YW
	 4z9cJTvH9YO2Q==
Date: Thu, 28 Mar 2024 18:20:34 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Benson Leung <bleung@chromium.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	Daniel Oliveira Nascimento <don@syst.com.br>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Matan Ziv-Av <matan@svgalib.org>,
	Mattia Dongili <malattia@linux.it>,
	Azael Avalos <coproscefalo@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jeff Sipek <jsipek@vmware.com>, Ajay Kaher <akaher@vmware.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-input@vger.kernel.org,
	netdev@vger.kernel.org, chrome-platform@lists.linux.dev,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 04/19] platform: chrome: drop owner assignment
Message-ID: <ZgVEcnQnFUG0dVkO@google.com>
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
 <20240327-b4-module-owner-acpi-v1-4-725241a2d224@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-b4-module-owner-acpi-v1-4-725241a2d224@linaro.org>

On Wed, Mar 27, 2024 at 08:43:51AM +0100, Krzysztof Kozlowski wrote:
> ACPI bus core already sets the .owner, so driver does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

I would prefer to use "platform/chrome: wilco_ec: " prefix though.


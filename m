Return-Path: <linux-kernel+bounces-45153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E705842C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CAB1C245EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF3579956;
	Tue, 30 Jan 2024 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="S/LRa7k1"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754079944
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641297; cv=none; b=opO6i1FrytTuSisEYrCCqwzev3PsCV+jt15xSxjHFzI5S0GdwmStdv2/OgRRmQVJy/zjjmAxQpIHbUMwsfQYybYiI3VrpLwCWJXmmb5pkrHK5d3JdjXBelIe5ucuKM67zuVNTRcQJmjBGxkLJ6DV8YuoAKjCl2LVgGJHXgxnF2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641297; c=relaxed/simple;
	bh=E4micvE7O+ZbfCsFYarptDn3Hd1yYBBH03FWbQeFOoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gekm3i/F2qvli+Zl6QbzAk6cPy+7AJCAA/HS9tAKtFs3JaVAvCBDMADTf4qOu6aCMWPwbW+eD/IqoOq7LXFQNC7vM6NgNPTASIC1DELrcOVMGbLIb+eWRFElnxc2ZD3z6XsbiVOPp1X0AjwIoXNTxHlGCDsqnveG7MvuQme/xek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=S/LRa7k1; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc26698a5bfso1268418276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1706641294; x=1707246094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78og88yF4pCuDlRqg/F7xnA9QQPhVIa54mFydxb6xAQ=;
        b=S/LRa7k1I6VkFGbMjJwp/QW0hek8NQEkABe3RQolvttUei2fqEK7Vd6XP3BmNh/5c5
         mLdEEyb3LIrVcn5oOpv4wHfCJfxnM2aFnlnTfHHk2XNytrTl1c7/Blzubi6o9ZzcXYTE
         5DsHE53pzEopVyRhMZ2ixUQDaSLtROgqEr3XCdNyt8lew3QPLJMcDN5ayXrjbYTtcsH9
         TOQX/j07fvJ10OsWzJG/N7pTX6x4F99gT8+NRGnu3JU4BUZNw0HI+aG1LlHISSXGKJKc
         dHE44i6w/ilDkEAEoat3tJP8PZvE+jso7cencgI9+0ajA8UZ8Lt4ik0dYAhrYduIRWjK
         SN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641294; x=1707246094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78og88yF4pCuDlRqg/F7xnA9QQPhVIa54mFydxb6xAQ=;
        b=tlXLm3xVlXywpyRm5bHSq/b4NEqxYl/By5MfVyJ5DsHoGkMNqJomVHIEUUv8XClEo/
         jJbNRwJ0LyxsB5/42o2DNX5VND3+dMrodMYdV018xAerT4y1nlvMMHASEa4iwXuZ5YCT
         uICXQAXeunVg7xDlb/Ea1c3Io2c16xOycSv+O2ehQQI3Eb2XjWRACQX1gtv6eRev676u
         inQbUHcHTe28AQVEdUo96qrxdePkOHrFtrSryBZ/CmwQ57xGqGS/4HFvTt2olS/5nvZK
         tW1IfHUz9u90Tz36LNPKMT1PDKxFtgTXWeWm518dpY1EzBuHcqOAWebT3AnfATwj+/Kr
         Gwug==
X-Forwarded-Encrypted: i=0; AJvYcCX+Xjbd9JAcN2v+5rnTzhSOWpiN1H4/oXZZ46f6XNVTVDaiLw8xpejq6ASJQO1baYR6i69kVrb1TgUBcjMMxtZ3mceIS3yfnBTddYr+
X-Gm-Message-State: AOJu0YyYvuySalRHlTeGvYb/yJthOS4jBP5Fi2bJkTwmuAWtTJu0TYZO
	Wyl+iYVjnVFF8w1ScWNivpPnk0LCmlzj33KlBkc7vHm2ih6z7VIqv/sG+pHzyhy2anS1ywtUaRV
	J/BhyuK8+ceIRG2bpsol65XLhq1Bo5poD5Rsfqg==
X-Google-Smtp-Source: AGHT+IEIheGpue36qp31pmYoALnxMN3CKJuNbqB2Ltwx8pEJRNlVwh1TE9U+Ybr/IFc6SWJpr7mnK28qhEHL7CgEogA=
X-Received: by 2002:a25:4191:0:b0:dc6:42cd:6554 with SMTP id
 o139-20020a254191000000b00dc642cd6554mr200359yba.0.1706641294016; Tue, 30 Jan
 2024 11:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130183124.19985-1-drake@endlessos.org> <7a8f3595-3efc-428a-852a-d9edc8ebb01b@amd.com>
In-Reply-To: <7a8f3595-3efc-428a-852a-d9edc8ebb01b@amd.com>
From: Daniel Drake <drake@endlessos.org>
Date: Tue, 30 Jan 2024 15:00:58 -0400
Message-ID: <CAD8Lp45ycrY-hkKVZGEQdeYmODauaShgFp2tj=QtEXK_C2tcYA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, Jian-Hong Pan <jhp@endlessos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 2:47=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> Has there already been a check done whether any newer firmware is
> available from ASUS that doesn't suffer the deficiency described below?

The latest firmware does flip StorageD3Enable to 0, which has the side
effect of never putting the NVMe device or the parent bridge into
D3cold.
However, we have shipped hundreds of these devices with the original
production BIOS version to first time computer users, so it is not
feasible to ask the end user to upgrade. And there is no
Linux-compatible online firmware update for this product range. Hence
a Linux-level workaround for this issue would be highly valuable.

> Is this the only problem blocking s2idle from working effectively on
> this platform?  If so, I would think you want to just do the revert in
> the same series if it's decided this patch needs to spin again for any
> reason.

Yes these could be combined into the same series, with agreement from
the drivers/acpi/ maintainers for the S3 revert.

Thanks
Daniel


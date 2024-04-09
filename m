Return-Path: <linux-kernel+bounces-136590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392BD89D5E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6D71C23054
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B1F8060B;
	Tue,  9 Apr 2024 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dBplVnu5"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251057FBC7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655998; cv=none; b=XlFA2XbCiDwF5jbPCjrh7Jmpx7H4D4OG3GmeqLfuFsxbVwS+kB5PQ/FUw/NXyt6M2DqtfJfIuChoQMC1eJ5i378aQhMGfjV/BVve806aH1d5W2tPowCa5sxpdXgi1Krqh5BWhMvhjZvlgXkI3FwPCG9y36zdEadzl3lzUsS2wfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655998; c=relaxed/simple;
	bh=3oLuWwlw+UA9jWk1fW4KtxdWBjfj8RgQrkzBwOMwbK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI+gIBGWcAdDDKwBM/d2uk9YggnsfWpX/mGh5vhu79+d3asLapPnwtM90ll6QCkV6bCwvQ10AQ37kS0gi2EAfuFw3yIgZdNoLx/CufgOAW+ygrZ281DXlSj8VPJkEgK/MH/ispSRzMFBxI3KhFUnUH0wZu1tbZglgh27Sm7Ij0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dBplVnu5; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d2600569so5664306e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712655994; x=1713260794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DidLSXvh5/1hQWAaoglzJs78OkjbxqNx+xlmjiU4CrE=;
        b=dBplVnu5aZRkIPj1XP4OF3jn+AaUXzjSREZN4Sx3nlvZMQpi0m4E8qvSybxqKIcFo9
         TqVkeV72ip2VHCBhwAW2Xaiynl0dB58rrn063U3aS/e443+a3Jq+PQoAtC3vOLn0vyVq
         1E1R7yK2qPjD29DieSDJVjUnvzudYTntL85lveu4N9ozaHnQJJblJGlY3iSV+NqhM/+0
         gmnU1XG8jfHoGAPLjFTlh225Mvkxs1C7psEfdOjMZjAXcpMBa4KB3ldVrtziCgej5HGR
         woxAgRZiKqetV3dRShlxS5uTWPNC6m5da0ptO44MTmyrRk1raneC3ltblv2vmnhF3XUo
         YOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712655994; x=1713260794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DidLSXvh5/1hQWAaoglzJs78OkjbxqNx+xlmjiU4CrE=;
        b=BQMQTG2t6iDqTe5MYfmlPDygJZFv/4q9gq7tcc7Kfrg3TF+ZzmUuDd+iA2cgM+ILXM
         p/9O5LPiRJZNUI4qaCAUa6KG9QQwEng7yC5GwFrG90rR26/jwVL9Bxybz2cvBm//uXyI
         HSFrD+fWP6KutRqAygDzanSqLecchjDO+fdC0QRBLcMwDvNY9lMitJRnKOR3bSqngcO6
         Fsjy2xVaFzT4XqQOcoGCHZpSxjhCTjMYGa16TzQpbwx2w9TtfFoDhwiVLvr9PCTxukrN
         Evt0EoEYx9Y5k4CV2VbRdUu64IrBO75KkFGcHTfNugnSmiCEBqrfijan5skbJB+m/CB4
         OWlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Co5a6lcatDaQfJBbBiCu5fn2VrWywLUrVG7dKYxUfN34zY2Ll9Wn5NNPnoMVHJ5v0ldfJqMvFx0pKEkcNSsTLTg8dVe9KLXEWBuX
X-Gm-Message-State: AOJu0Yx2V5ImqDNE85O4bXhI6TXYvIBUx93eQjflpV7EuHKg5XbxZGRU
	bhU6eNDKDWN6R63HcEWoMLAECn7JiYtDOeE0qMAr4OYu02ZokPROE0hrkTWqy+C1KDbcpNvjDFx
	/
X-Google-Smtp-Source: AGHT+IGUPj2e5LPR2Hj4C2JHChN4RXP1yVnwORdMsFjH79SWEABr1Et7O6S+Lrq+5AZFnas34QYSrg==
X-Received: by 2002:a19:ca07:0:b0:516:ced5:3afa with SMTP id a7-20020a19ca07000000b00516ced53afamr7482570lfg.5.1712655994292;
        Tue, 09 Apr 2024 02:46:34 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d452f000000b00343e825d679sm10574650wra.87.2024.04.09.02.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:46:34 -0700 (PDT)
Date: Tue, 9 Apr 2024 11:46:32 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 07/27] printk: nbcon: Use driver
 synchronization while registering
Message-ID: <ZhUOeCLdVftJviGD@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-8-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-8-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:09, John Ogness wrote:
> Depending on if an nbcon console is registered, a driver may
> handle its internal locking differently. If a driver is holding
> its internal lock while the nbcon console is registered, there
> may be a risk that two different contexts access the hardware
> simultaneously without synchronization. (For example, if the
> printk subsystem invokes atomic printing while another driver
> context acquired the internal lock without considering the
> atomic console.)
> 
> Use the driver synchronization while a registering nbcon console
> transitions to being registered. This guarantees that if the
> driver acquires its internal lock when the nbcon console was not
> registered, it will remain unregistered until that context
> releases the lock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks reasonable:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Note:

The printk kthread integration is not part of this patchset.
I see in linux-rt-devel that nbcon_kthread_func() emits
a pending record under con->driver_lock(). This is
a solution to prevent a race with the driver lock.

IMHO, it is not strictly necessary to take the driver_lock()
in the kthread. Instead, it would be enough to make sure that
the kthread is running only when the device driver is properly
registered as the console driver.

Well, we should probably discuss this in the patchset introducing
the kthread.

Best Regards,
Petr


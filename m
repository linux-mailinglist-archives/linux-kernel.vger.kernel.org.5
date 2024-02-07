Return-Path: <linux-kernel+bounces-56229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F155D84C7A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3035F1C24E94
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECA925619;
	Wed,  7 Feb 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AmMg+ImI"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045825561
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298517; cv=none; b=UcGoDasAM8mShZZnYiBx4qpJDdjKV6Nb/9+VSAC0SkW82U28K/Mawvic9ZBctJ0NWq1TZX3nxgSZ8oTxnePrnYPxrILLyPNLQ+XNwFDb16a5iaC3+PUGMOTKuMZBQR1Rtc5BT0zKhuDyeqaGmOcovJu/S6F/EdBH+I/wEupLl54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298517; c=relaxed/simple;
	bh=q5s5HsLedbmhWblfW5P5IttEtCuzggKcPzjW3KKyicw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT4zUOnTu+8y6rATiLlI8YlWeiJyRavyj3XQ7sygszqsIX7HO6yhg7qnktgd5RGn0V0kOvaIGCftHeTwnUhM9lLSAKAtyzxzkzxieCps+8DKJZdCs80KvaFGlEunX51p4C+2q9PA34qjq9cQMSNlE1vW9xegB1jK3JIQFatXXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AmMg+ImI; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so488838a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298514; x=1707903314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5lVUQ+esox3+YZ4FAL/zC0DsXpMXIO/eYNjqHysD3mw=;
        b=AmMg+ImIMR2rtLUVya0MMt2pI8rGkA13axJeo/bVoNVxjRk7GLS0pEGP3j6UpxohFy
         lK7W6DrBxP42CgBnlXfXj+pojDo3WLSflyEnEgOMCz4EqMZnNGPiXi+FFTw4QtRS5cys
         hVvzpo+wtWsnuSMEm7Oejx0A6WI6asPyUIrpJ1gh8WxM1K/mWwqsSuCTcB+KND5YLQBM
         87Qv/14EMs1lV5yploiKlzGWMQJSrJ0H/QhZS9SbFjCeNFGx5NYcOnkEJo9NZtUL1ZoJ
         MBqoQjIz4ivwNb5vi7Jo5NyUNscqB4wJViyNWh16kvN4Pk9gOMaakAwNSE5zT0BhzZ9J
         ZthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298514; x=1707903314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lVUQ+esox3+YZ4FAL/zC0DsXpMXIO/eYNjqHysD3mw=;
        b=TAID9KZnberaI016DxJ0pleNsCC1RdMLshwIUOxOFXKufL8yRfq2i6DVDBguwQ3Dv7
         mg3pkJ6WLp/2j4w9F0deEXT7+IG3RvXJ16U9rcE7U8IjYbBVdu3rFhWamconreCziaYT
         0lubo289cr16M1ckG0hCSDnxe5wW4jgHyXYRUYH/Jv3JSLuXG5h+ZOGEQpnJywpH5G9k
         ndIFCj2AFumZjbU0ysQcgWqFVVIc+pSOQucUQ0nPA+TxjwB99G0DPGf9S0WW/oGivUuo
         JbCO4miAI21EreHPn7hB+JRDFRdp3QG9Gyy35b9GWmXdZHOoGtqvt2k+6IsBTuszogm7
         9Rrg==
X-Gm-Message-State: AOJu0Yyku2u/UkaMabMWTlL32ZrRbJwRk0lN/zZv7aQyIlZl7O91Fbro
	WycypIhTJqld+21VEIbW2AOr/HQk4brKbkoERNaCAYDWUZczMvzABRIcvce+JuU=
X-Google-Smtp-Source: AGHT+IFtkf4VPj6Dgd7y1ZrX0bJMTHriq6dSY8L3xS8rwsKRyJe3YFW+KuqICG1BHJW9Ew1QCMXU5w==
X-Received: by 2002:aa7:cfd4:0:b0:55f:d90a:e68b with SMTP id r20-20020aa7cfd4000000b0055fd90ae68bmr3334578edy.20.1707298514040;
        Wed, 07 Feb 2024 01:35:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhmgTRPKEhVfGCCnkEQ42yYuTwdQJYl26xBRkdKw29eqoP001lXQsIHYUgOQ9qjLnnteyobOoMRvqN4Nl29ukI/AEBoNKWEa51A6KTBURKq6ahfunIDhDG7poEbZNcYTd9FGsS7NCtUpzWntWqKXRmru0qKsNccypFQFLaeQ6cwR/1U1Ra3kDu4GiufpM3sD4MqL+pnpGrWdrOqBO6+tR5Yj9BFD+mu3q+osq12fIQHlaqkZWg+RD4ETwe9suNk1FmVp7QlJsUT1DdUj44I3iw7SzzQCmYavJIbjOtAKGUYvWhviui8WH6MtaqaHaRKAsInUeuodwHVlOr518mlz9XdDnAfQf8AoJxYTJQdX9RI4zoxysjSYdYSE3RTaBWa5Ezt7yXNwXJDmmoKG4KdZC273ojpT8BQofy
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id q15-20020aa7d44f000000b0055ef4a779d9sm477495edr.34.2024.02.07.01.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:35:13 -0800 (PST)
Date: Wed, 7 Feb 2024 10:35:12 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tony Lindgren <tony@atomide.com>, Judith Mendez <jm@ti.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
	Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH 00/14] can: m_can: Optimizations for m_can/tcan part 2
Message-ID: <3rdpfjzahlcdxxszezxrk7vwvgwzpxxgsct32ydinki2xzbxz7@z2suuxtjnwjb>
References: <20240207093220.2681425-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240207093220.2681425-1-msp@baylibre.com>

Sorry, this is of course v7, forgot to add --reroll-count.

Best,
Markus

On Wed, Feb 07, 2024 at 10:32:06AM +0100, Markus Schneider-Pargmann wrote:
> Hi Marc, Simon, Martin and everyone,
> 
> v7 is a rebase on v6.8. During my am62 tests I discovered some problems
> which are fixed with this update.
> 
> @Simon: I had to remove most of your reviews again, due to a few
> fixes I made.
> 
> The series implements many small and bigger throughput improvements and
> adds rx/tx coalescing at the end.
> 
> Based on v6.8-rc1. Also available at
> https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.8?ref_type=heads
> 
> Best,
> Markus
> 
> Changes in v7:
> - Rebased to v6.8-rc1
> - Fixed NULL pointer dereference in m_can_clean() on am62 that happened
>   when doing ip link up, ip link down, ip link up
> - Fixed a racecondition on am62 observed with high throughput tests.
>   netdev_completed_queue() was called before netdev_sent_queue() as the
>   interrupt was processed so fast. netdev_sent_queue() is now reported
>   before the actual sent is done.
> - Fixed an initializing issue on am62 where active interrupts are
>   getting lost between runs. Fixed by resetting cdev->active_interrupts
>   in m_can_disable_all_interrupts()
> - Removed m_can_start_fast_xmit() because of a reordering of operations
>   due to above mentioned racecondition
> 
> Changes in v6:
> - Rebased to v6.6-rc2
> - Added two small changes for the newly integrated polling feature
> - Reuse the polling hrtimer for coalescing as the timer used for
>   coalescing has a similar purpose as the one for polling. Also polling
>   and coalescing will never be active at the same time.
> 
> Changes in v5:
> - Add back parenthesis in m_can_set_coalesce(). This will make
>   checkpatch unhappy but gcc happy.
> - Remove unused fifo_header variable in m_can_tx_handler().
> - Rebased to v6.5-rc1
> 
> Changes in v4:
> - Create and use struct m_can_fifo_element in m_can_tx_handler
> - Fix memcpy_and_pad to copy the full buffer
> - Fixed a few checkpatch warnings
> - Change putidx to be unsigned
> - Print hard_xmit error only once when TX FIFO is full
> 
> Changes in v3:
> - Remove parenthesis in error messages
> - Use memcpy_and_pad for buffer copy in 'can: m_can: Write transmit
>   header and data in one transaction'.
> - Replace spin_lock with spin_lock_irqsave. I got a report of a
>   interrupt that was calling start_xmit just after the netqueue was
>   woken up before the locked region was exited. spin_lock_irqsave should
>   fix this. I attached the full stack at the end of the mail if someone
>   wants to know.
> - Rebased to v6.3-rc1.
> - Removed tcan4x5x patches from this series.
> 
> Changes in v2:
> - Rebased on v6.2-rc5
> - Fixed missing/broken accounting for non peripheral m_can devices.
> 
> previous versions:
> v1 - https://lore.kernel.org/lkml/20221221152537.751564-1-msp@baylibre.com
> v2 - https://lore.kernel.org/lkml/20230125195059.630377-1-msp@baylibre.com
> v3 - https://lore.kernel.org/lkml/20230315110546.2518305-1-msp@baylibre.com/
> v4 - https://lore.kernel.org/lkml/20230621092350.3130866-1-msp@baylibre.com/
> v5 - https://lore.kernel.org/lkml/20230718075708.958094-1-msp@baylibre.com
> v6 - https://lore.kernel.org/lkml/20230929141304.3934380-1-msp@baylibre.com
> 
> Markus Schneider-Pargmann (14):
>   can: m_can: Start/Cancel polling timer together with interrupts
>   can: m_can: Move hrtimer init to m_can_class_register
>   can: m_can: Write transmit header and data in one transaction
>   can: m_can: Implement receive coalescing
>   can: m_can: Implement transmit coalescing
>   can: m_can: Add rx coalescing ethtool support
>   can: m_can: Add tx coalescing ethtool support
>   can: m_can: Use u32 for putidx
>   can: m_can: Cache tx putidx
>   can: m_can: Use the workqueue as queue
>   can: m_can: Introduce a tx_fifo_in_flight counter
>   can: m_can: Use tx_fifo_in_flight for netif_queue control
>   can: m_can: Implement BQL
>   can: m_can: Implement transmit submission coalescing
> 
>  drivers/net/can/m_can/m_can.c          | 551 ++++++++++++++++++-------
>  drivers/net/can/m_can/m_can.h          |  34 +-
>  drivers/net/can/m_can/m_can_platform.c |   4 -
>  3 files changed, 439 insertions(+), 150 deletions(-)
> 
> -- 
> 2.43.0
> 


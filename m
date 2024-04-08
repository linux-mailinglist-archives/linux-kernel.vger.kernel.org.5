Return-Path: <linux-kernel+bounces-135863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D9389CC2F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BCD284E9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63604145B2A;
	Mon,  8 Apr 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjLWBhcr"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C1F51B;
	Mon,  8 Apr 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603150; cv=none; b=hGkSF4qsL4Yjk3ErQ3oyZUgNLx/iJ1qxeJUMp9eCezP+Pt5/mtTBt8B6AXcMmQ+dljOlMhZjOVnBbsTYNYkNJ90kJ7i1MjvL2o+IVf75YYnW6JQ8HfXLhEXxU8WBn9TFj2vNOxEr3GbC7tfUF4VBXDReiPSkUy6yZLFjskGA2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603150; c=relaxed/simple;
	bh=8wFmekVOmu53+cf/lm5FpsFUvsp6gbs1zrZK0Pl2s60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUE2yvHrckFBHmIAxKgwACZIPC0706Sk3MsCSUoEenHUExCbffGzOWZOhgxuqV1V4jSZI583syhu1kh6bcMJKyzdtRTTTxNYeyLU+isKYSwPufu9S3vuEK+YTN2RF1/cNsh7/NlQmAHIRucgnZl3xdJ2YVPEoCpy0u3nvlcMK70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjLWBhcr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516dc51bb72so2809244e87.1;
        Mon, 08 Apr 2024 12:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712603147; x=1713207947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qucr3ZG4rBrwezBMSwb49mxeKQa8nls3JKt/ZN46Wsw=;
        b=hjLWBhcrfZWp3eeAC3Le8+0TNYctmveePDYuSdAb+MjdDnb/s+xdr18hkLxhNddx7n
         ZrHJIVOMWJQVI2JCmHL8m6t1hG9SGp1+Q60+fQwhYfBaPUT/Ig+gzem7x87x00nWmQWa
         hnzc70fhk+NwJe6pQzPE9+LROBhgelw/Tg0PExyZVCH0AXKUv8W1WxFK1BYgSOKXV7lF
         yJ2qNCFQlP9Qc52P3yHSPBGzHnPoW1UmA4Y34B5UYOHXLsQkXlbUZ+c8JV11mCZ7OGVb
         Sd5nrxKvMmZ+EcEZDuDO9lZerDRfQMSvQ4oUWhOvlin9UhSxF7FnE4z7FQj6JsLmUkfe
         DZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712603147; x=1713207947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qucr3ZG4rBrwezBMSwb49mxeKQa8nls3JKt/ZN46Wsw=;
        b=kfMs/kwNE6Tzf6hnK3aaTi5GI6OS3XPkjLCb3mMIvr4lrhfx3PQ0SnwCekC4ifts4z
         GbbbRZ3OY+MIlPb4v5J92Sk6a8RPMYqwjZU5ojaqr8ZuVR0jkF0f0e9rFO+EpleWBDoI
         nKNG/+H+rSbe24OWiMvz1XxUls5izKr9ho2gbhDQVPQ3B/ioOuiVXEI5YNEHuOvLW/fi
         2YG9IruGeZVGHVBgnYOVyizocy41dClcIdBLMGGkf1eEg63d1Dc3enHHiYXRM3kt7dTm
         GkDi7eFzf2AMoPJfNFph/SdaQegM0K0VKDqi8IGJrmxmIPB/cEueZJt3qVxj0c23fOoc
         Aatw==
X-Forwarded-Encrypted: i=1; AJvYcCWVdXdM/McPbXg3oOkjoX3LSbvjCLm2ymyqOoltI0pIGBxLHE9y/+Bh4OQHxE18q/QEilLUK2fZhPIGofyyImeL+WxTAmWV0rO1M57TbjoS4C1GROVIS3o33Me0ZHEtw7M4E5jQoMXO
X-Gm-Message-State: AOJu0YwEfiVrL0Qf6vlW3bkexiHP3EFAO3Kw8xNGdVZqzMWCmMr8ZIjA
	6bOauc+nnbXHNwbFx3BMajX7r0lmg6AnHvTmn7kYd1KnVS0iGjtIgKucv1Bh/5Q=
X-Google-Smtp-Source: AGHT+IFS6YdWF/r3zdQOLFUz3U9xCyj7XabMaoBTsrZUAlosxvGR85IjG7BnK0xafqIAIIfyaajI4A==
X-Received: by 2002:ac2:5edb:0:b0:513:23be:e924 with SMTP id d27-20020ac25edb000000b0051323bee924mr6455959lfq.59.1712603146362;
        Mon, 08 Apr 2024 12:05:46 -0700 (PDT)
Received: from foxbook (acgm220.neoplus.adsl.tpnet.pl. [83.9.240.220])
        by smtp.gmail.com with ESMTPSA id m15-20020aa7c48f000000b0056b0af78d80sm4452867edq.34.2024.04.08.12.05.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Apr 2024 12:05:45 -0700 (PDT)
Date: Mon, 8 Apr 2024 21:05:41 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Mathias Nyman
 <mathias.nyman@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-usb@vger.kernel.org
Subject: Re: xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not
 part of current TD ep_index 1 comp_code 1
Message-ID: <20240408210541.771253ff@foxbook>
In-Reply-To: <1f64af9a-0618-a7da-4acc-f043b6580308@linux.intel.com>
References: <58bca6f2-797a-4e20-a476-2294309afdd5@molgen.mpg.de>
	<20240405113247.743e34b2@foxbook>
	<7090d3af-18ce-40e1-8ac2-bf18152e5c4a@molgen.mpg.de>
	<20240406183659.3daf4fa0@foxbook>
	<c57f2116-8c42-44fb-9c32-6115ad88f914@molgen.mpg.de>
	<20240407142542.036fb02f@foxbook>
	<1f64af9a-0618-a7da-4acc-f043b6580308@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> It's also possible this TD/TRB was cancelled due to the disconnect.
> Could be that even if driver removes the TD from the list and cleans
> out the TRB from the ring buffer (turns TRB to no-op) hardware may
> have read ahead and cached the TRB, and process it anyway.

I thought about it, but my debug patch says that the missing TD was
freed by finish_td(), which is called on TDs considered completed by
hardware. A cancelled TD would show giveback_invalidated_tds().


Anyway, we now have new information from the reporter. My v2 patch
keeps a log of the last five events processed on each transfer ring
and dumps the log on TRB mismatch errors.

Unfortunately, it looks like the host controller is broken and signals
completion of those transfers twice. The log below shows two distinct
events for TRB 32959a1c0 and that the coresponding TD has just been
freed by finish_td().

[33819.676314] usb 1-2: USB disconnect, device number 7
[33819.676331] usb 1-2: unregistering device
[33819.676347] usb 1-2: unregistering interface 1-2:1.0
[33819.677861] xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 1 comp_code 1
[33819.677886] xhci_hcd 0000:00:14.0: Looking for event-dma 000000032959a1c0 trb-start 000000032959a1d0 trb-end 000000032959a1d0 seg-start 000000032959a000 seg-end 000000032959aff0
[33819.677902] xhci_hcd 0000:00:14.0: last xhci_td_cleanup: first_dma 32959a1c0 last_dma 32959a1c0 status -115 from finish_td
[33819.677915] xhci_hcd 0000:00:14.0: handle_tx_event log -4: event ffff9e19c38eb1f0 ep_trb_dma 32959a190 comp_code 1 len 0 slot 6 ep 1
[33819.677925] xhci_hcd 0000:00:14.0: handle_tx_event log -3: event ffff9e19c38eb200 ep_trb_dma 32959a1a0 comp_code 1 len 0 slot 6 ep 1
[33819.677934] xhci_hcd 0000:00:14.0: handle_tx_event log -2: event ffff9e19c38eb220 ep_trb_dma 32959a1b0 comp_code 1 len 0 slot 6 ep 1
[33819.677941] xhci_hcd 0000:00:14.0: handle_tx_event log -1: event ffff9e19c38eb230 ep_trb_dma 32959a1c0 comp_code 1 len 0 slot 6 ep 1
[33819.677949] xhci_hcd 0000:00:14.0: handle_tx_event log  0: event ffff9e19c38eb260 ep_trb_dma 32959a1c0 comp_code 1 len 0 slot 6 ep 1

At this point we have set the "interesting" flag on this transfer ring,
so the handling of the next event is logged. We observe TD 32959a1d0
completing normally here.

[33819.677965] xhci_hcd 0000:00:14.0: handle_tx_event event ffff9e19c38eb270 ep_trb_dma 32959a1d0 comp_code 1 len 0 slot 6 ep 1
[33819.677979] xhci_hcd 0000:00:14.0: handle_tx_event event ffff9e19c38eb270 first_trb 32959a1d0 last_trb 32959a1d0 ep_seg 32959a000
[33819.677993] xhci_hcd 0000:00:14.0: process_isoc_td event ffff9e19c38eb270 requested 192 ep_trb_len 192 remaining 0
[33819.678004] xhci_hcd 0000:00:14.0: finish_td td_status -115 comp_code 1 frame_status 0 frame_actual_length 192

And then we get a TRB mismatch error on this same TD.
The dumped log shows duplicate events once again.

[33819.678022] xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 1 comp_code 1
[33819.678034] xhci_hcd 0000:00:14.0: Looking for event-dma 000000032959a1d0 trb-start 000000032959a1e0 trb-end 000000032959a1e0 seg-start 000000032959a000 seg-end 000000032959aff0
[33819.678047] xhci_hcd 0000:00:14.0: last xhci_td_cleanup: first_dma 32959a1d0 last_dma 32959a1d0 status -115 from finish_td
[33819.678058] xhci_hcd 0000:00:14.0: handle_tx_event log -4: event ffff9e19c38eb220 ep_trb_dma 32959a1b0 comp_code 1 len 0 slot 6 ep 1
[33819.678066] xhci_hcd 0000:00:14.0: handle_tx_event log -3: event ffff9e19c38eb230 ep_trb_dma 32959a1c0 comp_code 1 len 0 slot 6 ep 1
[33819.678074] xhci_hcd 0000:00:14.0: handle_tx_event log -2: event ffff9e19c38eb260 ep_trb_dma 32959a1c0 comp_code 1 len 0 slot 6 ep 1
[33819.678082] xhci_hcd 0000:00:14.0: handle_tx_event log -1: event ffff9e19c38eb270 ep_trb_dma 32959a1d0 comp_code 1 len 0 slot 6 ep 1
[33819.678089] xhci_hcd 0000:00:14.0: handle_tx_event log  0: event ffff9e19c38eb280 ep_trb_dma 32959a1d0 comp_code 1 len 0 slot 6 ep 1

Regards,
Michal


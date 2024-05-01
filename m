Return-Path: <linux-kernel+bounces-165686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5BD8B8F86
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1A91C2188D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5B4147C7F;
	Wed,  1 May 2024 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="PNNt6GIx"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361B1474BF
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714588159; cv=none; b=i35SyqSiYiEKe7xgtbGvkgvmoRLwLZwbTn4YKHnz5fBaU2CDiSR12Yd4ikd7pY9mOR4l5O3WPL/KtjpAGowl+gxJ62l/wMKIr1iXa3gx9LcGTJ6QK2ViWRgaomByjTeg2NIJTr1vQO8pAJOcGOoqamqnRG38G29MYz7fAedbLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714588159; c=relaxed/simple;
	bh=THVFJ9NHFLgWi1oxltoNvQXatcR4HTHJmtOxAkP7Mz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/2E2rMqrpmk820w6yPoIiEIs5ORkgOtvioU3KPgCMtgEAVzZygrFzF9z0qTONGwm7GPQzxAdQO6jQhhlA0TLKg5eqP78syAF/+WOigk6uGjmpjNHGs+gVvhpq0dETVWCCjbphXmWkinbxXj+vLUS3EbSPrHatBlZIIcwzAK4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=PNNt6GIx; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-51ef64d04b1so422363e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714588156; x=1715192956; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i1SxH6Yi2QDvFptePuvBwgOkc7k60xPbDJ8MDa/H9BA=;
        b=PNNt6GIxtsi1ZH0TulUEltGSYef75esf3Y7B7CI/yaqjfRF3Xpf7y7+pT97YSwozIr
         h42r8TYF4baQuLUw5LBy8bNnEtEvuu6VO4iKV1cPj/ahI9zg8n9pd/tQnYQJPba5OkZv
         hvvMRcN6GrdORi00CDI4GksKQHUCmljSS5XZ8DbFI2jcDPe0IugEuVYtTBEzkhqJf+hH
         E9sqS4VVc3KGfZJgwivSPXnE39zNS3olIU2gghIZ1ZQNoISPP4na+beyZInBe+M3bbYN
         Ba3iQ5oQDkmertzHrGanAE77R8cAkQnr4l4PyWr2xlOiuKze30578ArlY1T2Qe3bKJtM
         BK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714588156; x=1715192956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1SxH6Yi2QDvFptePuvBwgOkc7k60xPbDJ8MDa/H9BA=;
        b=DifYXFqwv7ibaO0Qn5CPmb4A/f5ip0IMG7t8kV2Fgsk9W9st+3V4wEKONowgUCwyVc
         /GLbPf0Uj4Cm2SYbTGtQ+jdYGd9nNAHKf+A2Skne55AD2/tlrG9UYRV2OBfE6s6Igtq0
         3YgmQxu8aVj1QX724GVpQJuJaUEyABRdbIqL/LZ8RGv+K4e+pUX8tLBBLUN3bQr/sfVx
         fzN8R3dQD2eeO7yBe2FXSgaTpulZTIvS+kptbi3vKTRq3WvbIyHkbC0EpY+5dYZyFfu5
         8z8354CJiFpJ3be3e8y8wIZPIU/yhaSCyyr/rSoF39l4VPMH//mev8h074QfM7Cx+0pV
         IwEA==
X-Forwarded-Encrypted: i=1; AJvYcCU1PRyIc9vQAjszjSfNiMSZRSfigQTmOEyWzesoCXbu6/dXZhtQKg+Z8M7cRzczNb1ud3yPSbZEUJ1YIxrX3ntB0vLaI+sVvWJdQHKU
X-Gm-Message-State: AOJu0YyhOIUTRmC2Day1YRH/skXoM6yia+akWwptfnGDHgA6l3FwhtIq
	XA8Ra9Etm0KGEmoA8AIxAUQvlmJOoUfyfpnkXpshSAyhRF/cQeuuK2yI82Xn7OY=
X-Google-Smtp-Source: AGHT+IE88hVIU2jnQTwuqTvy58xxi494R22YPulFAfwib/5JkkL+UtEk2v3BfunXAhNF6rJr6WtaQw==
X-Received: by 2002:a05:6512:48d4:b0:51e:147d:bd2d with SMTP id er20-20020a05651248d400b0051e147dbd2dmr2098684lfb.39.1714588153665;
        Wed, 01 May 2024 11:29:13 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id o13-20020ac24e8d000000b005178f5ad215sm4975613lfr.122.2024.05.01.11.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 11:29:13 -0700 (PDT)
Date: Wed, 1 May 2024 20:29:11 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <ZjKJ93uPjSgoMOM7@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder>
 <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
 <Zi4czGX8jlqSdNrr@builder>
 <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>

> > n  |  name     |  min  |  avg  |  max  |  rx dropped  |  samples
> > 1  |  no mod   |  827K |  846K |  891K |      945     |     5
> > 2  |  no log   |  711K |  726K |  744K |      562     |     5
> > 3  |  less irq |  815K |  833K |  846K |      N/A     |     5
> > 4  |  no irq   |  914K |  924K |  931K |      N/A     |     5
> > 5  |  simple   |  857K |  868K |  879K |      615     |     5
> 
> That is odd.
> 
> Side question: What CONFIG_HZ= do you have? 100, 250, 1000?  Try
> 1000. I've seen problems where the driver wants to sleep for a short
> time, but the CONFIG_HZ value limits how short a time it can actually
> sleep. It ends up sleeping much longer than it wants.
> 

I have been doing my best to abuse the link some more. In brief tweaking
CONFIG_HZ has some but limited effect. 
Saturating the link with the rx buffer interrupt enabled breaks the driver.
Saturating the link with the rx buffer interrupt disabled has poor
performance.

The following scenario has been tested. Both ends of the link run:
* server.py
* client.py

One end is an arm64 quad core running at 1.2GHz with the lan8650 macphy.
The other end is an amd 3950x running the lan8670 usb eval board.
Both systems should be fast enough that running python should not be a
limiting factor.

-- The test code --
server.py
#!/bin/env python3
import socket

def serve(sock: socket.socket):
    while True:
        client, addr = sock.accept()
        print(f'connection from: {addr}')
        while len(client.recv(2048)) > 0:
            pass
        print('client disconnected')
        client.close()

if __name__ == '__main__':
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.bind(('0.0.0.0', 4040))
    sock.listen(1)
    serve(sock)
    print("something went wrong")

client.py
#!/bin/env python3
import socket
import sys

if __name__ == '__main__':
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect((sys.argv[1], 4040))

    while True:
        sock.sendall(b'0'*2048)

-- test runs --
run 1 - all interrupts enabled
Time to failure:
1 min or less

Kernel output:
[   94.361312] sched: RT throttling activated

top output:
 PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
 145 root     -51   0       0      0      0 R  95.5   0.0   1:11.22 oa-tc6-spi-thread

link stats:
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 32:c2:7e:22:93:99 brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
       3371902    7186      0      48       0       0
    RX errors:  length    crc   frame    fifo overrun
                     0      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
      10341438    8071      0       0       0       0
    TX errors: aborted   fifo  window heartbt transns
                     0      0       0       0       1
state:
Completly borked, can't ping in or out, bringing the interface down then up
has no effect.
There is no SPI clock and no interrupts generated by the mac-phy.
The worker thread seems to have live locked.

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
run 2 - RX_BUFFER_OVERLOW interrupt disabled

state:
Runs just fine but the oa-tc6-spi-thread is consuming 10-20% cpu
Ping times have increased from 1-2ms to 8-35ms


-- additional notes --
When tweaking CONFIG_HZ I do get some changes in behaviour, the cpu
consumption stays stable at 20%+-2 with CONFIG_HZ=250, when increased to
CONFIG_HZ=1000 it jumps up and down between 10-20%.

I don't have access to a logic analyzer but my old oscilloscope is
almost reliable. I could confirm that the spi clock is indeed running at
the expected 25MHz, but I could observe some gaps of up to 320µs so
that's 8k spi cycles spent doing something else.
These gaps were observed on the SPI clock and the macphy interrupt was
active for the same ammount of time(though this was measured independently
and not on the same trigger).
I've been drinking way to much coffe, so soldering is not gonna happen
today (shaky hands), but if it helps I can solder wires to attach both
probes to confirm that the gap in the SPI clock happens at the same time
or not as the interrupt is active.

I'd be keen on hearing what Microchips plans to address. If tracking
down performance issues is a priority I'll probably not spend any time
on it, if not then I'll definetly dig into it more.

Let me know if anything is unclear or if I can help out with anything
specific.

R


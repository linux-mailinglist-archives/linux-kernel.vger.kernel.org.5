Return-Path: <linux-kernel+bounces-78572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012DB861537
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9E4B23D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA9E823B3;
	Fri, 23 Feb 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKcDUuWF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52C20B02;
	Fri, 23 Feb 2024 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700872; cv=none; b=c/fej5enJNsOsQBuOEoE04D+WhLK/WhfJISdRGzuB6Wk3VZ9lGmME8L+hDUm+XTxOJLs1Hp/rfyASRgw/DuHbSz97ivL7SjGNaKcumCWoD1ZhRvm8EEcvJ+art+ZojRJZ4gq2cDwZYuEfdDF3CKnBca8DXPH1LVaWIWg6kFsNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700872; c=relaxed/simple;
	bh=46B9fXDJG233uKQHkYve91+ux45hfkkJQhoIKZSUOkU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LSvG4gsaOC38HdZqHthX5yqpRgMgBl4VD9B+6J1jbQcvAf9NAa/Zjd1K/fcmc7BOoc5mbGgopkb9HKJfZe+cQrK/RhY3TP+y6kzvV/fOR1Yyj6OGdlpL0kAdUd4QwEFzF5L9WZrLnvUPXF/a383oTK8az/NwpGvkAY0CEP/1Xgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKcDUuWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEADCC43394;
	Fri, 23 Feb 2024 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708700871;
	bh=46B9fXDJG233uKQHkYve91+ux45hfkkJQhoIKZSUOkU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IKcDUuWFMbW8KAoY3FoYKiWWzPiQPmZ7eygPygHSRAhGZ64alNTOjpExJ5nkH4wZ8
	 HDcm+9JCBoCqBjVIZ1nh36/lKxpcrJk66Gualzc0E39SZ5zRhjG25lqF3t/qeSuidx
	 10hkukveSd0UTZWmjmsPCSgdsZIpDiUbr/qEdYrwk1++unyfjtHgzoR6wzE57AzHa5
	 cGGyoIZom4siyK6vfbkLh07+h9xDcO5XENldpCJYg/ruTavwximHkzbJaPYqWCUtMG
	 OIy/Zpak+lX2e7qqNVwUtOsD5+y3vINVFT0dbkI8c5Tsqf4Cq4eBIzRwNhz1TvZzNq
	 GOIEYUCLy2v/A==
From: Lee Jones <lee@kernel.org>
To: andy.shevchenko@gmail.com, pavel@ucw.cz, lee@kernel.org, 
 vadimp@nvidia.com, mpe@ellerman.id.au, npiggin@gmail.com, 
 christophe.leroy@csgroup.eu, hdegoede@redhat.com, mazziesaccount@gmail.com, 
 peterz@infradead.org, mingo@redhat.com, will@kernel.org, longman@redhat.com, 
 boqun.feng@gmail.com, nikitos.tr@gmail.com, 
 George Stark <gnstark@salutedevices.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
In-Reply-To: <20231214173614.2820929-2-gnstark@salutedevices.com>
References: <20231214173614.2820929-1-gnstark@salutedevices.com>
 <20231214173614.2820929-2-gnstark@salutedevices.com>
Subject: Re: (subset) [PATCH v4 01/10] leds: aw2013: unlock mutex before
 destroying it
Message-Id: <170870086764.1691019.14397200556333161730.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 15:07:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 14 Dec 2023 20:36:05 +0300, George Stark wrote:
> In the probe() callback in case of error mutex is destroyed being locked
> which is not allowed so unlock the mutex before destroying.
> 
> 

Applied, thanks!

[01/10] leds: aw2013: unlock mutex before destroying it
        commit: eb0f0a751c8e26b212f78fe7325fa2506c5cbb4b

--
Lee Jones [李琼斯]



Return-Path: <linux-kernel+bounces-132704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FBC899906
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300B128359E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2483015FCEF;
	Fri,  5 Apr 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IepPMTgV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74715FCE3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308236; cv=none; b=aWnTvC00vSiyLQppvsmI6PVaaeERjpBP47yRGUqlGCKZXevbAm2U23yLcjRX8rl+K5TFYPaVzR7hh/kTnUNq3hktDQwq0+WqDm8q1TDAagSlI2qeZxajyEMLK1dYm2b31nbeSWmkJlB0V4yHANweUvwrQwH7MpAz3ckPZBc822Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308236; c=relaxed/simple;
	bh=81eM6jiXwtalbaZcX5u6YOuEklPGUYeCbo3s4KCd5z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnfcsQk15lSh1F4h0NaPUdUV64O0N2qy1ew+tl2aVkPHbscypJB+kVBz5shjAr/2cV10gKZc+FrHCj7rwjn9snJcfVdSRap5DW2lzgEioBSWuXqVlXxOeotVZMlBACYNzRu77smz8ZjaTL5UNuK4d6FfQz/Gf6JMh6yumQgjdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IepPMTgV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712308233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+32tc+g6bFUi7eOalPmpwKSPNS4pCbzAaqy2IDSlhk=;
	b=IepPMTgV0r+/r6V2tMB/znrmABGss4dQAC/PrjayrNThgasv6ELwAp4uqCQGaiyYzxM8GE
	a2yTsggviijYz0dWB+I0wRg78D8PX2T/g7aIHB73mtKTTIc6vSbtRthjVu6vj4plL64lh8
	15V+J6rtNOJHQstcHborSfjNA6aIG7k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-ta9lZDMeNLKgdaWG8kQb9A-1; Fri, 05 Apr 2024 05:10:32 -0400
X-MC-Unique: ta9lZDMeNLKgdaWG8kQb9A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a5198c1a6f4so56034766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712308231; x=1712913031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+32tc+g6bFUi7eOalPmpwKSPNS4pCbzAaqy2IDSlhk=;
        b=iztpoXOqujBVUdhV/fVMUUUcDLgJMxxQ+l1rnLjQgg3gc9+oCHm2LfZCjbkgRS3fx2
         VkVkITHwlyqvG9RButjivxy7B3e1cPbxfUwNVGQ64bDtRCZgMuWFArZsDwY2cONVCEln
         GnY2K94ne1c29DXRSkYcydfUoESGMvjlvLnCPFbibot+ROZ8InoZ/Sdvl1o8vF2voWuP
         Qwm4bPTqh0jHvB8c5Z2/kIFKSVKySXq9oCejk17fwuUpcSsPnpj9TC9W0QEkL95HwfNH
         2FbykdqxK3Wp4VV+7LPozpUoPBiN3oi3X90tS4DjjYIY6dd3o112UEdjhMjJ5jH+TYq3
         G6ng==
X-Forwarded-Encrypted: i=1; AJvYcCUwQT0Gu4CkhaRxq3GS969fJkGs2YU281ppOijNXUIlIDXeRZf2EOUL1GZ2nYcel9k2dPeZl078V3qaVn8YYLSPOsAbMipueIzMguxm
X-Gm-Message-State: AOJu0Yzx9hvn7FXXJqLEpQnfotvRBgsgieTWcehkE++rFobkRs3dv1We
	l8UYGvregxhrPVqyUvH3JKpIDr84LNRNTXb3vOdIa71rn7zkxHlFeutnVN13o/eC0H7pZl7enm6
	hDCv7psK3eCDwtNTdZ5kW65AfgskWahfOXdIrQQbyIobDlK5vpOZxLHrv4nMEew==
X-Received: by 2002:a17:907:7ea2:b0:a47:16d1:113f with SMTP id qb34-20020a1709077ea200b00a4716d1113fmr908612ejc.47.1712308231281;
        Fri, 05 Apr 2024 02:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuVZr8zHBruV3lHP+YdrL6HnH+f7vAApqXuUuk45CM5IDB1fylmdA8Q2RPCqFaOslqpFidew==
X-Received: by 2002:a17:907:7ea2:b0:a47:16d1:113f with SMTP id qb34-20020a1709077ea200b00a4716d1113fmr908582ejc.47.1712308230994;
        Fri, 05 Apr 2024 02:10:30 -0700 (PDT)
Received: from [192.168.0.182] (host-87-2-128-150.retail.telecomitalia.it. [87.2.128.150])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906b01100b00a46aba003eesm607927ejy.215.2024.04.05.02.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:10:30 -0700 (PDT)
Message-ID: <c959833a-9074-47ed-b9dd-e7e276cee0f9@redhat.com>
Date: Fri, 5 Apr 2024 11:10:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] sched/deadline: Make start_dl_timer callers more
 robust
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>, David Vernet <void@manifault.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E . McKenney"
 <paulmck@kernel.org>, joseph.salisbury@canonical.com,
 Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
 <20240313012451.1693807-14-joel@joelfernandes.org>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240313012451.1693807-14-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 02:24, Joel Fernandes (Google) wrote:
> For whatever reason, if start_dl_timer() returned 0 during replenish (it
> did not start a new timer), then do not marked dl_defer_armed, because
> we never really armed.
> 
> Further, we need to cancel any old timers,
> 
> This is similar to what dl_check_constrained_dl() does.
> 
> Add some guardrails for such situations.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Makes sense, added as part of the defer patch.

-- Daniel



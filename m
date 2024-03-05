Return-Path: <linux-kernel+bounces-92180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6A2871C59
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C456428596A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D00B59B75;
	Tue,  5 Mar 2024 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKOk9+4W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908C5917F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635846; cv=none; b=bI4Gx0r+HdsX8BKcS6dyJ84eps6mIKNG/LO7DRNYiu5H8kMFMOkwf4IagH5fUIaafhJfSjtlw8GNqixVxoVOzFQlH8n+WsON0PhH4UfcsdbIGviVnhC4VWLYK2gxpMMprUk2nNCteVfO/LaP54wjmILvkuKX4gLQ8BBzCjV64+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635846; c=relaxed/simple;
	bh=mfZrCRo1Le3xvhlG8sWohmJVn8/2Kh3YDhSk2jiRO84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WWxY/cX0rNmHIikpkqpSszdlMmcA+Z0NG6su3EXgGrwvpgNIONPPQc+6FB65MuG58Q8DHfWrjVjc1M45cW43InH8w/NQyUi5yzcwDfA046BSOvyk/4my2h61BLseecHLeIYdgvhbZZ3HIvS2157NZT2MKOpbuBkzKiyo/H4ZS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKOk9+4W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709635844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVYxwMtTQeWVE4Tn/hbP7z3GmeUiFdt48l1PZlAeQnI=;
	b=EKOk9+4WGbO5PJUlNNTC5Uoc75ZXrlravWmPG+VUUCckGSburxCfO03K86mCv2QBWcvA93
	8idi9wBlvUvAe5GRihcW3dESrAoh6SL+VlgRVE1tspMFPP96ZHzwgXH0Eo9tzmofLFCWNv
	AxEZ/jk4lOl1mVBVMhXBaGPHmQw1sfQ=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-D0SL6x-eNzifmJvg9RXd1g-1; Tue, 05 Mar 2024 05:50:42 -0500
X-MC-Unique: D0SL6x-eNzifmJvg9RXd1g-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso1004762276.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635842; x=1710240642;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVYxwMtTQeWVE4Tn/hbP7z3GmeUiFdt48l1PZlAeQnI=;
        b=YXpfTqv2dGAg/AS0Nzsn2OP7uDXyn6dSb5htOXakryD3OtE/8VssuMXrfGucLK7YN7
         lMSs5BMtKqDrOwuxqQFTJZApy1vVj29/u52O+RsXoACW//DADmkp3Y5jdzvz1HCQ1KYH
         wuYF5qaTb2Y45arwtPwIPmgEIjPTIQpTpvdzAqMOS8V4VdNaakj77RX2F9Kd+qCzGXAD
         PQh6IPqpbZ1iTa7hVONh6tuu8or8CFlwsIl1ks1PDr1w3MymM6BbSEJThtROwLiAw9FO
         8AcciJlrAq6jeyGcBj8y77v2XY44dJOhi2326WX36JN9yf5G2W9qaoMNEAJu+5jYUmvg
         k2zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVarcWEi8vsTTtTbKbtsNwC8ohU282DAPu0DAPKtON3vAXEyY2/VdLWvEfPjJuYTYHl5HMDTCHcRGhJh4Cv2wqTRaTTJmt+dV0KO+LF
X-Gm-Message-State: AOJu0Yy+XZJ7VLQoL1SRgPzSYBctXiib5luKyOGAQrDdTfMQogktWRgt
	D9+TXuxGgnRINpa1V8efZ0PX4WSO8oWrmgU0YLVAXHvsC/Q3ANkr9/F/9FMVjinyLwaOoKuXcoq
	dh++6Bfsu+zx87SeSyWYLVBrZ1JDKGaEnPSKx/L+dm7kjZohIGLf4HlwMeR+IIw==
X-Received: by 2002:a25:5102:0:b0:dc6:d738:1fa6 with SMTP id f2-20020a255102000000b00dc6d7381fa6mr8621713ybb.6.1709635842249;
        Tue, 05 Mar 2024 02:50:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHgWX9vlc6wtUV8FjAMELah6/Ipv3xIrmGonysDFgQXpWH2CiR/WNvQZE1svKJDPFQUSbS+g==
X-Received: by 2002:a25:5102:0:b0:dc6:d738:1fa6 with SMTP id f2-20020a255102000000b00dc6d7381fa6mr8621700ybb.6.1709635841978;
        Tue, 05 Mar 2024 02:50:41 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id q4-20020ac84504000000b0042ef5b8b697sm1455107qtn.32.2024.03.05.02.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:50:41 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/9] sched/balancing: Change 'enum cpu_idle_type' to
 have more natural definitions
In-Reply-To: <20240304094831.3639338-4-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-4-mingo@kernel.org>
Date: Tue, 05 Mar 2024 11:50:39 +0100
Message-ID: <xhsmhfrx5dkao.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/03/24 10:48, Ingo Molnar wrote:
> And gets rid of the double negation in these usages:
>
>   -               if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
>   +               if (env->idle && env->src_rq->nr_running <= 1)
>

Yes please :-)

> Furthermore, this makes code much more obvious where there's
> differentiation between CPU_IDLE and CPU_NEWLY_IDLE.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>



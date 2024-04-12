Return-Path: <linux-kernel+bounces-142637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7F18A2E21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6383B2241A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631B56B9F;
	Fri, 12 Apr 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnwvDbSy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFFC56B71
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924421; cv=none; b=R7RPL7oq7HyS4y915+7j75RKl98SVJTzXWCap2VqzYCZ9GWeT/myQP7J9Jxc9iBT8plEhgExfWgY1QOcwAG/8BG1jw0/kGE9WkAQrRdE7ng3Ch1/A35igdRuTqK+LFPSo6JTXTxReihg+GkxxgdGv/QNSCBVI29+QwRll8GKJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924421; c=relaxed/simple;
	bh=WFmjjSrbeFjEmhLlBiWpRUSOMUY8KYm186SmcYNgeYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKBuZucUCrNFS6UabsP4BB0RuwvFQzid+4eQp/El6R0HsXxNeMWiMVSwerh8cKjUMkhUF03uQNMsQfVlfWUkOpWEKciO8sbbTFF1fb+2V7PnNQ6Q9dOFq9omJcjfHU4jQWZJD5Xeprh/3y75Lv2OBtR+k9Oq5OhPpXvNoenM5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnwvDbSy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712924419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WFmjjSrbeFjEmhLlBiWpRUSOMUY8KYm186SmcYNgeYs=;
	b=KnwvDbSyCCN6150R11tW8lCAVfxfezflU7itrHTMDV5xWelNbu8HMC3S46Ghml7Gv8MufI
	4BZRa7PHAwLWDl/4hYO/KMrxB4ShUbO4u46y50Ein/DhWyW0i+jCYrBGYJ+cSLBoPtahdM
	S/t345Gp+H3+KbL+qXqvZqm1O/dCyh8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-9-QdF3YVOoOkCvSq48YhwQ-1; Fri, 12 Apr 2024 08:20:18 -0400
X-MC-Unique: 9-QdF3YVOoOkCvSq48YhwQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-789f2dee101so77135285a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712924418; x=1713529218;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFmjjSrbeFjEmhLlBiWpRUSOMUY8KYm186SmcYNgeYs=;
        b=MQb0TRQ91Hv/WtTV0H3YblsK+dFJinRPgCs7TdnDaF5JgJczCln2YeDvs8GT/dfBon
         XuJao2eY64Zfrv/ngulHXLOcTnz7aWg36mUwAquXn+DbfxCJsgqnomgXYCZyuC5XUsSN
         LC1y3stuINNlR+79gh1hvcvlC7VX9cv6iHwUMseC9zroxNyk5vnRUBKcfYzBmKx3tSx3
         gPi/3xFeci9u/XAnt8PghmICIYBzcyl1yJWSFLtcmga3+ZrrkDYmbZT45IDEVVTAI93Z
         btXgSs/JvS2hfjRXlgDNMhC4gHZyAYURto4d/n6rvOj/K5xK9skmYAyhAxqs4uffByDu
         iDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOD9riwFcprULIOS2pmVvkYPpTZYk4mY6ixRX5BCqr8eLgl9YHKt3IW1+q1DSTFJSlTaJE+fixOLYEwNJkUYRqBitwVA9E83sshW2M
X-Gm-Message-State: AOJu0Ywqz/3ZHCXv2ctLkE7CsH8el8cyfYkCFKsVMsitXfL9K8Zx2pMa
	ZDci+SnAobduTl3+jS8ym/lTe81cpw0/b+KsD3apXsglaoeLHSBCC/0X+Z17/cz+nWit/S0nAEL
	NjcMmAlYBKoSD+vJ1/7PE/khI3MfnpZYQCP6WCoKGxaZvhxeuk9e+6ouAbGjIBg==
X-Received: by 2002:a05:620a:394d:b0:78e:cc24:f3fe with SMTP id qs13-20020a05620a394d00b0078ecc24f3femr1810322qkn.2.1712924418003;
        Fri, 12 Apr 2024 05:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl1RGrNpjG++v4K183eeVV70SCzpHYcpeio2nSYQsNbwwZxjYJTxzbIAebB5VpqAVwSeJLGQ==
X-Received: by 2002:a05:620a:394d:b0:78e:cc24:f3fe with SMTP id qs13-20020a05620a394d00b0078ecc24f3femr1810306qkn.2.1712924417731;
        Fri, 12 Apr 2024 05:20:17 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id m29-20020a05620a215d00b0078d65a42db6sm2319340qkm.95.2024.04.12.05.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 05:20:16 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, mleitner@redhat.com, David Ahern
 <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 1/1] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <20240411100536.224fa1e7@kernel.org>
References: <20240411120535.2494067-1-vschneid@redhat.com>
 <20240411120535.2494067-2-vschneid@redhat.com>
 <20240411100536.224fa1e7@kernel.org>
Date: Fri, 12 Apr 2024 14:20:12 +0200
Message-ID: <xhsmhy19i93ib.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 11/04/24 10:05, Jakub Kicinski wrote:
>
> Some new crashes started appearing this morning on our testing branch,
> quick look at the splats makes me suspect this change:
>

Thanks for the testing! Seems like my own testing wasn't thorough enough,
let me have a look at this...



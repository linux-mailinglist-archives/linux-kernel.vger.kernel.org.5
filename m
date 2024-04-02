Return-Path: <linux-kernel+bounces-127597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8FF894E2D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34754283D72
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8FE224D6;
	Tue,  2 Apr 2024 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Bk19R7NC"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F12253380
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048517; cv=none; b=aqiD3b3zHbDmP64MbArGdH2TZ1EtGa+TkDsMZOoyj7uEpUdiD7AFQPWQyR+pynFH6rTjTwWJfSQAiX8NPweg6Raix/WZg0xuDqUpqaQzZbybdTVGBF9K2RDFtgEwgW+g6Hllh2wXJhuGiVE3FTbmAWLH2Wupu2JS3kM11OkqpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048517; c=relaxed/simple;
	bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUgM3HagOX8oE+7bhAkvOp4cc0EPzTTGdVIoV5lV8FGcUCtzGhWeGmAIjDG9xdPWQi0jeOTa7ceMkK82ZE0JmQPDXoxRVnuf9pyXvESISOs4ZxXDDcUDQmnSDkrGbMJ293yogquuyIoPX6UZy8plH9rVCUHnfbaxfL7MNfh6LYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Bk19R7NC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eafbcc5392so2014270b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712048515; x=1712653315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=Bk19R7NCRilf8WwJf6SywRpuAyZDEFpDBtBCK5rekyy0uuleQ5WMQcRhZ8fBsDXwY2
         eN6WCyBETWAT6OGyu1TgAuwh1WgwEAxqXfKwwQy0fG7vm6REIaF21C3fo+tiMQKJlz4/
         pXsjkjWcoVvHTsnLaEi3noMjKvgfVlFgCOHZgQKoIIw4CTva74HZm2PeSeLLtDJ3k1tF
         9wqdzXtib6rEVcz9XCKDpCzimC0Due/nC1nskaXO7i7bWSVL9GRVA0uIv8ZiPauooHDm
         fGnP5w4RiAOz+0lPjdBZm0wotuxuPRVk5Voq4qpj1doXn2hrplSGn1P/GZilokAqMLal
         pE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048515; x=1712653315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=hpuJvcCaGfL/7Nv5r5iHEe8X2CN4Yi1CA1YSjN6vqY0S9mzyzsJPH4Dsdrd64Op0Tn
         6yhJdBGkWK9i2rJxgCEyNNB6+XkNesxg53ZvBs1GyXVJc+TyXx1C0vcI3wOiKQvxTPpI
         uwtHvvZZXcJ2Ve6zPoSL+1aWIY03tY9P5OXB1o77VYG66x+bGDzU2UPpHPut3n3yZNj9
         AlV0w4jGrZ3quKnnvLnPi4TS8c48p1qaHmkXLauWfGVUeN+YX2MGIC3yS/vs6rL7SJ4J
         VjsFm7a61AZOeprVnMsQvo5H/M0aUbUXVMo/XFH8XL8idNbqE3tkoCHt15VZDCp+nVFH
         bDKg==
X-Forwarded-Encrypted: i=1; AJvYcCWdwowjVP9+u+K0/ebyJwh7theq0TSPNY86y0j9U8Sdz+OItqvTMsKNeOznEI7ho08y+xL8TKYRZlWcJ2dcfW4pVei7oQZyYurbZKGt
X-Gm-Message-State: AOJu0YzM5cz9Zk5174+bQmdTftY4tt5pPe+vwO5pgwj/2vVtYquxncVa
	m7d43k+cK69+dAmurdl67+EP3F2yWMLFpHiPcCkUjyWAcNzPxZB5c66A6N4omIX+PKiHYSRYm6J
	xXFvDNnqnyd74M79zrQ+PsQ+7ixpom01ZlJBGUw==
X-Google-Smtp-Source: AGHT+IE115Sfhw75rH/JpVYlQIiEI1B1wUChGJ0wfRlxcJzODhoGWe53bZKJEIgJGp2HAJPfhytgtQBkvg8e1LvxiSw=
X-Received: by 2002:a05:6a20:8f05:b0:1a3:d515:ff2e with SMTP id
 b5-20020a056a208f0500b001a3d515ff2emr10978527pzk.37.1712048514640; Tue, 02
 Apr 2024 02:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a803d606150e375c@google.com>
In-Reply-To: <000000000000a803d606150e375c@google.com>
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 2 Apr 2024 11:01:43 +0200
Message-ID: <CAGn+7TWYLnYRRNJfPPRtrNL3E7DDkf0X6RBAxszYfMKx1=EeoQ@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in sched_tick
To: syzbot <syzbot+a1d7495c905fa16bea17@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr


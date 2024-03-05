Return-Path: <linux-kernel+bounces-92181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC153871C5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282B21C229BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85785A4CD;
	Tue,  5 Mar 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+HUBit9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA75A4C8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635851; cv=none; b=Co8MbIek0E7CYOh0Uk/7B+5MIaSHYDSvAF5mK6YH+m9vsQ+gXrSTGkKlfi5v3PmARoqxqEZDw0k8RtnjHFrPpZtIJN8ON1OQf1cNRmnL8v8fe8v152mQGaxiCejRzzdZ4nffXBeWXQTGQOsdSITIc1pVD/Te8B25nwsUZCPcjvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635851; c=relaxed/simple;
	bh=ZHKgHmXsg/JKS0bzUstw6QLZ1pcz1Cv7iz+eHZtLRuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ITrP+wWWag4XtiGIO4992MM5B7tLfqlqoYTf9u1rs9iF5bV0C1JazkQV499ZAj0IoCb2X21L/hAtQvyoDtuiU6CwalHqGexcgUHx/hZIRurJZtG5vQXd1iw8/jXr4eK5B/wsIDFD644BGDm73lC9fST6iawMV8JY+ZKGLmIdJq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+HUBit9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709635848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIC1W236jDbhwYw6Luaw+d1BRGMWesWgAzYOzs9nE6Q=;
	b=N+HUBit9ofd1cyyIZMxlAqG0NbLAQG8Dh1VTseTF8F52kJX7OXuY8dyc6J2L44lBBsTETu
	Zxu2VEbsRRy/Ijav7Pcfuvx6brNg0b50TM1Sz1QIz0CC+B40NAfxtw7Nkmv1Z0EaN3NhBX
	OpA8JxJ3WFuTcLq/RhGOc/r9uxCHgW4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-9AWGJkZQOXitoDcBwgrZgw-1; Tue, 05 Mar 2024 05:50:46 -0500
X-MC-Unique: 9AWGJkZQOXitoDcBwgrZgw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42ef02a3861so21843891cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635846; x=1710240646;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIC1W236jDbhwYw6Luaw+d1BRGMWesWgAzYOzs9nE6Q=;
        b=M+NXm7hQVt0m+afJJ4NhufLXgpRJZpplCRbdf6pYOwkyYP3aRKssZS8xb0WahrhP87
         aUiNlOtR7J7K6R/DDZwhDZ6SNmAJoejhE4BwiEzL8fhEv7TX8kEJjp7TF3sMdbTSceEl
         lF1wv2bu9E+ddLNUyELVoVYaXGioKt6fX8wyJssqPzrEAEDG+5xqzEkvT3PwY+LQq/+N
         KiWzCjwBTfPSEc0trXB9jnXGK3VZxguW5zvD65Oh/ieIVE/nYqeNCyeYYompgsNyuEso
         hK2KXbxrYsa+SapPb2pPGC3ZShKS7P5cdc/zMFZU6hF1NcfUKssYIrbLoSSIJgFwql0k
         bUhA==
X-Forwarded-Encrypted: i=1; AJvYcCXMuYE1qVxsNEaQLji1A1+dlQJvNTF8ih8zNSpf5E1IHCntFoQmzjk5M1qNGOZiv0Vz/0KRdT86txvhIHCR3OdkNJbd492NHiBmNjUt
X-Gm-Message-State: AOJu0Ywzxg6iLNH+IefqaspsMxgmAo8K13DUxES3uCYXl+0xYsbugzK/
	DtjtQt/piXev+z0/v7bSVcjyui9nM8vdvo0UD+BtTg0vsXb+iBdjDhon3s9rjgAEVzsqzcTz9WI
	YaJBmQfwsL6MfNN4tbZD1+WJ3C9fdKlYqwDwZjX0KgaYR+J3lwUCipJnDizTALA==
X-Received: by 2002:a05:620a:c15:b0:788:242f:469e with SMTP id l21-20020a05620a0c1500b00788242f469emr1552978qki.41.1709635846374;
        Tue, 05 Mar 2024 02:50:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE/0I8tYUsH5Dc5G0+BOshGF3kRbnfj3bZdJRstNcmje0sDFu827/BVRZf+jFknJVOCyQLMQ==
X-Received: by 2002:a05:620a:c15:b0:788:242f:469e with SMTP id l21-20020a05620a0c1500b00788242f469emr1552971qki.41.1709635846135;
        Tue, 05 Mar 2024 02:50:46 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id vv10-20020a05620a562a00b0078835bfddb8sm507370qkn.84.2024.03.05.02.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:50:45 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/9] sched/balancing: Change comment formatting to not
 overlap Git conflict marker lines
In-Reply-To: <20240304094831.3639338-5-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-5-mingo@kernel.org>
Date: Tue, 05 Mar 2024 11:50:43 +0100
Message-ID: <xhsmhedcpdkak.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/03/24 10:48, Ingo Molnar wrote:
> So the scheduler has two such comment blocks, with '=' used as a double underline:
>
>         /*
>          * VRUNTIME
>          * ========
>          *
>
> '========' also happens to be a Git conflict marker, throwing off a simple
> search in an editor for this pattern.
>
> Change them to '-------' type of underline instead - it looks just as good.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>



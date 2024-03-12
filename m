Return-Path: <linux-kernel+bounces-100756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17091879CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D402827A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6A614290C;
	Tue, 12 Mar 2024 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MuVoKAGM"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE9139572
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274915; cv=none; b=isutljcJWIozVT4MoGRpdOl+YFheEILisR0rKtdDnQ6rP9i2VErV352zNIwrtn+ZfjZxpg7lNoe1JKSCn/eakmxJ+N/hBIlrhgxmt5DyL2BIWGJI3eszc3Rs2WEhZOVB3BjaJcgwAQOc9Oclw0slfykuASIvPl4WnkGFBST20Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274915; c=relaxed/simple;
	bh=uBrGiE5O6AuIFTtj/jlLiZozZS5Y38ZEH3vQvSZc0eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PccoYAPH8WeO+QKJoXT+GmZy138yWpZ0sf8V2B2coCCHCZCgzVDJsh94MJDQb/emNW8gCwcLzgVviVLuuit6NOdgCIJycU7xBXZL65UqL547QY6bkfyooGA0yIEh0aZRearV3md2s+fP0JeN3OztvTv408pTeLs+OWBx1rF+QQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MuVoKAGM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso287178a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710274911; x=1710879711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9hWOoexzYOGaCNkqMwBrhgeF73SnW0W5uRMgtvkkqg8=;
        b=MuVoKAGMZb5bJJTJF8C2EnnJ3k/C6X9EYQV/IN1n3ILBsqsE0V8RdpJ6SyeRMKkn+i
         2E5sK8uk0nG8RY/LVrLP0CklopZ4Ot/YNBcQBJVbyG/cKvo7TkvM1pPnBbMw2K607R1R
         B42PC3a769z5mDD+dGRRlNLIqyfPjkuC4up2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710274911; x=1710879711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hWOoexzYOGaCNkqMwBrhgeF73SnW0W5uRMgtvkkqg8=;
        b=SmThgkBJClp/wOLZn6K+eACJ1JOdb0FaOZyX/OQd1PloXO/WPW7edFMTV8gECB37Lw
         AzTAX38yUHKBwemfIyx6AcrrkYvjcSYljiNFMFJxma5ZnVb/hQwOpoIl142ub6OiDOca
         VJiOvrW3yUi4FEyhI0zVB2CgWGktfUWzT8rJQURY8pEfN9PskSx+Ez+zwzHbUq8+xDT9
         scYVwsjnLiKqhuAJi9RXO039v2r/j3VXi4aUlIEPYjB4uUDynhy+n68Jg0YzAvQuUsBm
         QdGNK9EOqDRz3eKC0aD3vtN3tUEUhCAUlbaTF1tqKkSCHowCsSaxDW2lPmSsrfOxTke6
         jiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXtvsLof/9H712X9vFJv90hUiR/9o7jw8Hk3eyZdyQcgMf4okyoCBl5omi0X+zXiJRUcyyF0YVgb1FBK0On/ehSnWfaj2ZI5DYJ196
X-Gm-Message-State: AOJu0Yzpx5yCl19UcqJSMwkToBHGKmeaAdIO2a2XwV+8DWA7xylf95mu
	Dlzsm0bl0Ykng2ceeLPDpZY8JNuPTuZUzc0FvvtU3OVJjYAtbZwu3VU15ioBg+ebnzdPZ3HdKxg
	pVdz2Eg==
X-Google-Smtp-Source: AGHT+IGL4GV+H8WQr8DI4vauBkCvzxebNMqQp9kc3sbC+F7vOVBUdnhbJqlW2pONrf0iHRjb6gTCmQ==
X-Received: by 2002:a50:8581:0:b0:565:471b:c047 with SMTP id a1-20020a508581000000b00565471bc047mr3685424edh.0.1710274911592;
        Tue, 12 Mar 2024 13:21:51 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id dc10-20020a056402310a00b005686edd650esm1148944edb.43.2024.03.12.13.21.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 13:21:51 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so344955a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:21:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdI1JbIll2IoW02KQSgnMS7YBpqkv6XeDk9i2+TQ95n0DxRrB2NXx1pxeouSUKUSymho6qZ/FSfCAmYKqV4kzEZg4iiN9OX5EQDPUs
X-Received: by 2002:a17:906:f0d8:b0:a43:d473:685 with SMTP id
 dk24-20020a170906f0d800b00a43d4730685mr2747782ejb.38.1710274910654; Tue, 12
 Mar 2024 13:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308-vfs-pidfd-b106369f5406@brauner> <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
 <20240312-dingo-sehnlich-b3ecc35c6de7@brauner> <CAHk-=wgsjaakq1FFOXEKAdZKrkTgGafW9BedmWMP2NNka4bU-w@mail.gmail.com>
 <20240312-pflug-sandalen-0675311c1ec5@brauner>
In-Reply-To: <20240312-pflug-sandalen-0675311c1ec5@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 13:21:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLkkGS=50D6hjCdGJjkTbNj73++CrRXDrw=o_on4RPAg@mail.gmail.com>
Message-ID: <CAHk-=wjLkkGS=50D6hjCdGJjkTbNj73++CrRXDrw=o_on4RPAg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs pidfd
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 13:09, Christian Brauner <brauner@kernel.org> wrote:
>
> It's used to compare pidfs and someone actually already sent a pull
> request for this to another project iirc. So it'd be good to keep that
> property.

Hmm. If people really do care, I guess we should spend the effort on
making those things unique.

> But if your point is that we don't care about this for 32bit then I do
> agree. We could do away with the checks completely and just accept the
> truncation for 32bit. If that's your point feel free to just remove the
> 32bit handling in the patch and apply it. Let me know. Maybe I
> misunderstood.

I personally don't care about 32-bit any more, but it also feels wrong
to just say that it's ok depending on something on a 64-bit kernel,
but not a 32-bit one.

So let's go with your patch. It's not like it's a problem to spend the
(very little) extra effort to do a 64-bit inode number.

             Linus


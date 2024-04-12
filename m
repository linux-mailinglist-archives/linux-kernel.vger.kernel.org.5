Return-Path: <linux-kernel+bounces-142962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3CF8A3292
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B0F282269
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F165E148310;
	Fri, 12 Apr 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bvaTy03D"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706511474D9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936187; cv=none; b=GHhiOttmHMjnAEsojdIgz97GoHZi8z2AO9d5iIsg1AJMg9QD6WHoEdevrSIl9DPKrR63Hd30SSluLNpiBsu5W0gI340ujEvVubc3KbNRcptukXJbXIFlEG2hOrxcV4JZDD7hnzfkz9mjdp/lmknJcxTcx+xuSwUEKD2VJ+kwxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936187; c=relaxed/simple;
	bh=zk6vSbvVLABQPy9qvih4/WpwqnOU2palNUl7YmxTXoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwTxaxkUN3tca3RIO63D9ow6o8msDQH3kqPNpcxXRC7904TLlbnCtmX80VSbGIHSpeCp/kJklzQ6imt/o150JuChYA8xjmWbYtRPHo5rhymA5+PcV1iEu7hl4qM8+UwKFT/0GJtEWGV13MXjdB7af3rylDEKTWZjIOmSlNLWV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bvaTy03D; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d3776334so1369064e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712936183; x=1713540983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KVn7Thh2jHUPFYoXLOH9HKjtBO3lIRg/yTLKB6jzC4g=;
        b=bvaTy03DMYBuQtOdnYMsMppbIEQqDGZelylmuXqB2viW9iRz1eoARf2UNhHHh9zObL
         v6NMzSsA03ksrKv2NNVczfqQLoIr0SW7MFLOWUJuqWQwckZ+WB8w8bMVMFgTX1msBvXo
         kmQUhGjfn6BYDtbiSvpVlvTX2L059oxajkGCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712936183; x=1713540983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVn7Thh2jHUPFYoXLOH9HKjtBO3lIRg/yTLKB6jzC4g=;
        b=wvLQHljifMM2fU1ooZlqtFA9nADSaE6i2uqMvn+kZX6IeswzRhoK7Z00C1qozY2VX+
         uUXRLK2pXdxWBa5MEl/DG9PybOe9AMIbVRA1VJy6yjOJ9bV+Y9or1sRU11TYotM/oX/c
         V7OB5QGRI4HkOskwBDu5Clss/swRdOe8t4yiQ+MqI2ii3iBnmWjEK5PvAifDPLCbFArA
         Ug6FuQX7OZlLEQTpdIN1WTJuuqidvCkRMGUaSMzV0UrOKuUNOUd2hk/62pmupzWmM9+G
         QOHy0PRz8gWfkHgGGzQCvxI6Yw5jocmJvRca/gXrbmhEoVtBCA6l8CGifZffQjUVuf93
         C1nA==
X-Forwarded-Encrypted: i=1; AJvYcCUS4aHVq8gRwNYf2Z6rBK7Htu6TOKdi7cBY9fzeF1L9XLJgPesHqm5MnxiiRyz8xdy8yZk8DUxcNfx1IMR+xgY7UVVei3f6qzP+mvXv
X-Gm-Message-State: AOJu0YwteKiU+mnIIo/zHK705RPa0m2jHw4p3kScIiKiInLG9MeTk5vl
	q2OO8Gu6e5/n/QeY3OSW5A2tXbxzGPmw/Nqv4RVyEL6sMe4nr6RkSFtyPdrRK9nmlSNJsw8LhVJ
	KbR8JzA==
X-Google-Smtp-Source: AGHT+IEKgdxyrJNTRCzTYRoxFMOlyPFH65WqfXeBjtR4sS1wsLfzzNyd2+lzMPfGsh1ufOUz7fGJ0g==
X-Received: by 2002:a05:6512:158b:b0:516:c763:b4f5 with SMTP id bp11-20020a056512158b00b00516c763b4f5mr2296629lfb.3.1712936183572;
        Fri, 12 Apr 2024 08:36:23 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y7-20020a056512044700b005178e88b4adsm535565lfk.86.2024.04.12.08.36.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 08:36:22 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d0161e13so1284295e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:36:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAR2Ypd5yPnS0Sb0pFYmEpi8lengWUgCwW4pSSDlbCCCbJW6H+xtqYdXBXxNFP6Fge7mIPrG6lq2T4twWsytThAhbi24nXRkloGYLN
X-Received: by 2002:a05:6512:3a85:b0:516:d06b:4c5d with SMTP id
 q5-20020a0565123a8500b00516d06b4c5dmr3115635lfu.37.1712936181752; Fri, 12 Apr
 2024 08:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner> <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
 <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
 <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com>
 <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com>
 <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
 <CAHk-=wgEdyUeiu=94iuJsf2vEfeyjqTXa+dSpUD6F4jvJ=87cw@mail.gmail.com> <20240412-labeln-filmabend-42422ec453d7@brauner>
In-Reply-To: <20240412-labeln-filmabend-42422ec453d7@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Apr 2024 08:36:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuHY26QgDHp7yM5hVPOzVKO2FDwSHgNEu_jN9d2B_G0g@mail.gmail.com>
Message-ID: <CAHk-=wjuHY26QgDHp7yM5hVPOzVKO2FDwSHgNEu_jN9d2B_G0g@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Christian Brauner <brauner@kernel.org>
Cc: Charles Mirabile <cmirabil@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 00:46, Christian Brauner <brauner@kernel.org> wrote:
>
> Hm, I would like to avoid adding an exception for O_PATH.

Ack. It's not the important or really relevant part.

             Linus


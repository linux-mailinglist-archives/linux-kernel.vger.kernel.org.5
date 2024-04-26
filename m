Return-Path: <linux-kernel+bounces-159629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5128B314A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C771F2294D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A34413C3DB;
	Fri, 26 Apr 2024 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="caNgvyEZ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9AA13BC2B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116477; cv=none; b=PaC7W+mjT4N1Bs6QnHj2SXQ+7UoY4RtZZOBZdcKxR0XnxTdd+tFkbTpUokP86iL7788/N/wzpEa1C4g2ojDVWKo/wGS6xvotfL4j38y/QuUCVtrD4DIAhOKBwR5hd/RTrHLqJleRm1mE0bNF0j6u6GXPD1LJXT713wOmP+yy9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116477; c=relaxed/simple;
	bh=48Ba5A32Cjl2L/cHDAoV0QpV5Af4tdSMnVjMTBjS/94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlmFKc1AFAnptazwLRD4wGC9H0+OoJECoxhruT1bNWo+/Cx1xV7f/F7LePzepuw2nAB0ysvBsTAxMiGM82TKx/wZkxBYMomuBkBiBZyzO/6tfBvBXzN6GU6kpU4E5Dlw/lXJHXSPIKnnygztCYttbOjQffqDQrv5eiky9HwFUzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=caNgvyEZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so6021a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714116474; x=1714721274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48Ba5A32Cjl2L/cHDAoV0QpV5Af4tdSMnVjMTBjS/94=;
        b=caNgvyEZNso/SyeZ3gZn0PF0kTL1bIMSTmYaDdt/8HDl9KxZYWixg+Ml0RWGd590xc
         q0v8POQCz8BXCuvzt/TuiLIaXsZFuf85zUHCxyaoA1c3zll4Y+Va1ho0nnZ9XPFWonXQ
         WjNX4GcqzF3FuIMXquYDtkpfcy1iNCdDzcXwK9x6HRGBwSlrP7JhUJe1B4uUuuLxhVgp
         YWACfrZMZ++lq7i+in4cmBm2gw5kcj/zI+sK4tgijYCIihKpjb/bKs0xkSICdbHh4wPw
         XF8KAkHwm5fCyVETFnZO4WN1DuS3T5CGb/BxuWu8YpPefzhqgzNMcBwNLDGaaNGGYpO0
         ipPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714116474; x=1714721274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48Ba5A32Cjl2L/cHDAoV0QpV5Af4tdSMnVjMTBjS/94=;
        b=TXDEqgH9gWIlRAfJm9ESCFGz0srXXSvUVBfQbGubVDws0bAyYJBq7Uxz5Xn5l9KLr2
         9GfL1X73+/jyceU3iLDFUsRXyYCdKHrGIvvsmVttbsOar8VaErEMdUctdsHpv7QICZnZ
         TJuuatIxZ6U6TeFK2+2CNPPTUwTHEc69c00bgv4BCMPOCKzRxsCAUAKvF+JfskAvPKsc
         mCwdaHZ/8hIwVjT6/Sx3YqkEdIj1T4BkmCwI6re1DJ4rIjKsUAbDjWDSu5A4JhkIoubv
         +Rvkl46N56mFc/S02zi5nVq4VUD75UD4m35pzhSMpg3LYWeZHMGTVqy9j1uA6MxWr9Mc
         LX5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3yaBGs9nPno3ixO2qSxjD2ZWWoP0o7lpx6yWTmofJK5kFImUxDEy8xlWWgYTn0S436eQc4p9h2QfFK+UOu7HmKaUisUWV2CDmErg+
X-Gm-Message-State: AOJu0YylZTdzdLCMAAHqFZDaKqAjD+Ew0BAr8GfzFA7twQ8Msg4COSly
	7Via4NTRe/UIyBU79pS6T93qglgDoTML8wO4Tmx01r4o/C7b3/EcMPelpywl/p1RpxjGtlCph1C
	bdTEXjl1BLLqZNaX6csibTLbbFsEI3yKWEtTA
X-Google-Smtp-Source: AGHT+IHEn5uOD9GlXoPdHm3uPp4edfxe4KynTFwvW8GmIsgl9y2/YROhvW72ZIDxBxLHIb6M0J27TSxSFjNOrAmpu00=
X-Received: by 2002:a05:6402:b2a:b0:572:583f:cc4c with SMTP id
 bo10-20020a0564020b2a00b00572583fcc4cmr30849edb.5.1714116474078; Fri, 26 Apr
 2024 00:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065143.4667-1-nbd@nbd.name> <20240426065143.4667-6-nbd@nbd.name>
In-Reply-To: <20240426065143.4667-6-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:27:43 +0200
Message-ID: <CANn89iKOdbyuaCsU9FhLeWJS1QYMXr7NffAwPbYWApxpQrMTAQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next v3 5/6] net: create tcp_gro_header_pull helper function
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:51=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> Pull the code out of tcp_gro_receive in order to access the tcp header
> from tcp4/6_gro_receive.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Eric Dumazet <edumazet@google.com>


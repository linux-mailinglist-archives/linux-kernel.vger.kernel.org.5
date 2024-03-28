Return-Path: <linux-kernel+bounces-122389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAB888F611
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D9729764E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32284376F4;
	Thu, 28 Mar 2024 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSYVSlAz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496DB648
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711598124; cv=none; b=naBS7apMJreU1yRsndTQ1CsCCRRn/FGbvPuC6ET3sUOZDIUm1NWzp0AEPdp2302OILKoYLvlmNESGMJdk2uO43YGpQKH1+nvE03NF5R8csLrGDt9CS+qrSzXN6AkPhljLjL3jCQ3khF8ncZ/5C0jbivvBHtc/3Br96/4cn0mIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711598124; c=relaxed/simple;
	bh=MO7qxQbB/W08umKliTUVY9ZKtNLKCFZsGJELh9kwmPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXcSgKp5kaRW82bBYhOpxiwH1auKZuenlgfRPDd/RFiX0etl/xMZKqezY4dRebhRbht1xn2RhMxMRPXth73e38LRSLUEbtx273WCXpbqupJ/qrrTpxOQDPypCZAZ+aT8TQGWWjSXKJ6dNqSs2eoVaC7dzTfVy4vWMU7oIYQzGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSYVSlAz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711598121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MO7qxQbB/W08umKliTUVY9ZKtNLKCFZsGJELh9kwmPc=;
	b=BSYVSlAzmNk5aum9OLomBUUD/JMwa8nx1WMjz2yegoUpXrbJ9dH8gLmaxEKyIFroUd83vE
	oGVHlDPsf9Jd57y8fBtjkhFGzURLIcjMAlywHohxVPW8gxfxA2GSGnW6euEMBscuOH08UP
	yoiSqQF30OLW+AiYeGE5vuSYRAyPs7E=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-bZReW4MNPAuUXdJmm9R6LQ-1; Wed, 27 Mar 2024 23:55:09 -0400
X-MC-Unique: bZReW4MNPAuUXdJmm9R6LQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a04aded772so530355a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711598108; x=1712202908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MO7qxQbB/W08umKliTUVY9ZKtNLKCFZsGJELh9kwmPc=;
        b=o1ByPUpToUdD7nlnMh85jGwngW7cl0z7wLeas3CazNGa++2kq6Q6LgqK8OU14E1v8Z
         h3rXscwe9H6P4NHwQ9/tr+MwDAZDBPwknG6RGsgOrh8IyTRyhz5B7lKC5ivMulVPkRWM
         XPBg+94RHQXhNh0VjCAdsYM67uJykbWXjKb3EK1rCIxezAAAMlLeV2OK1uqxqWilLLnt
         VE9veixQxq6O6LDj76dzwMjFEShuE3tA+ut5MBGm+cuQRfTyC5gA7i1sByIEu4nncFfX
         fNn8OWmB/9XI1qcnSHXJaNJDDHHYNEbpYKCsC45lI48q9LHi7L6wf0Dozo5XH78cfslE
         Dcfg==
X-Forwarded-Encrypted: i=1; AJvYcCU5xwL8OrANzAg+ujyEjL2USqCAlWKHHYt8unhRfTIaShiXprPKj53vEYghhbce/0ZfVw6jyg2XCUiW/jCobVx1ZlsQps3aIapoL2of
X-Gm-Message-State: AOJu0Ywwc9AbIYS+mbawrpQod4tSdBKW2jHVsEfgmooypmieiUfawDlP
	YY6OHachtQ1+4YNPJTod/AVt77vcy9mQ4bq2CkqDzE+C30VnA6bGGKU6+2Ze2UzFqRfzk1JkR2c
	b0edkj/0G7G9aeET8U7MN2thA1Nkhg5SSYVYaqycGy2THuFMCe6qs+xJ0N8iq0u+pMXK9dFpzhK
	2Rk1LhPZm8EPWrUuk5g2L13bxMY4XBArJ42RMZ
X-Received: by 2002:a17:90a:f493:b0:2a0:98c5:fba5 with SMTP id bx19-20020a17090af49300b002a098c5fba5mr1465811pjb.14.1711598107988;
        Wed, 27 Mar 2024 20:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx8M6X9k7I/i9OsfTwP8yasMzBtlJG+nSmhmhraZLACoKJt8ceIYZ4+2nqucgJU9r+l6DISx3nMdn4qnfupE8=
X-Received: by 2002:a17:90a:f493:b0:2a0:98c5:fba5 with SMTP id
 bx19-20020a17090af49300b002a098c5fba5mr1465793pjb.14.1711598107659; Wed, 27
 Mar 2024 20:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328002149.1141302-1-gshan@redhat.com> <20240328002149.1141302-4-gshan@redhat.com>
In-Reply-To: <20240328002149.1141302-4-gshan@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 11:54:56 +0800
Message-ID: <CACGkMEt5fz9mhZ4YK=Oe+n0kx0YKe4hOnGvVQwh-w4rSfs7uRg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with smp_rmb()
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mst@redhat.com, will@kernel.org, davem@davemloft.net, stefanha@redhat.com, 
	sgarzare@redhat.com, keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:22=E2=80=AFAM Gavin Shan <gshan@redhat.com> wrote=
:
>
> All the callers of vhost_get_avail_idx() are concerned to the memory
> barrier, imposed by smp_rmb() to ensure the order of the available
> ring entry read and avail_idx read.
>
> Improve vhost_get_avail_idx() so that smp_rmb() is executed when
> the avail_idx is advanced. With it, the callers needn't to worry
> about the memory barrier.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



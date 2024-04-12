Return-Path: <linux-kernel+bounces-143279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BB38A36AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7AB1F25732
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571E21509BB;
	Fri, 12 Apr 2024 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFO3sae4"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5748915099F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951996; cv=none; b=DfNfppzUuVDkGfovf4RHuDeRfvhYzHB1zF7IPpfq6hpp3e7o1oDxS2r0qX9hI1CTQ1n4jK9yGRADkwG++WeUdLNw2gELmIhe37Ab/YWrmgjRIBbeEM0Ac2qDh+1vOlVGm57gbVoNpxXt8hBQ1bRsXLGc/j+wKEgRLgFKKQ8aZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951996; c=relaxed/simple;
	bh=36OsBtzi8touilTyPMVCVeWyHaAC35RPhFw91LknUmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfIK2faAwLoU8jcYZ88Uo8EE0kewo4nUYozqk5ojIDqQmk3YOnvx6UlAZr94eRsWLtFw5yiQ6yco7H83VS5oQtDi0+WJeT+b1OmZ5O9Fj5J/DaOuf9FSC1fTuD7o75vasV4hOl9ayFbeVjFF1DJORXrqWPft/U3ZUCvIrCOFgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFO3sae4; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69b40061bbeso6745006d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712951994; x=1713556794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPQz4q6QEnMsxEgXrxtOlOJIEb7W/IfVxZZ4u95+bqo=;
        b=YFO3sae4HNlgkYsTfIyaRrIatrclSzO4FQLhdyiQO4+wICgoVNpzS1VqSsZZynBOIL
         F04xY8YNmW8bsRtEee9u6ElYlb1vGmat2/CwMfwufEykfitqe6fc9opX6Wn/NsYv/K++
         x2WGV5HQAdQHiVGi1hvoccV8LKYBB+2fI0vh1MKK3vdT/9rTuh0h0kOw+Y8KsmHF1UaH
         1OrKxstmrq/URumxrpEAzroFANst5Rd/4UdeUtIP6PtJw4Ire9be85ctps/y+tMLafyz
         pnZMrAN884DhjpS8npBvrWJyxg/Dx0zavKUsNj2t6zpSQ8Y4gJ904//t7GeJxhe2jI2p
         OcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712951994; x=1713556794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPQz4q6QEnMsxEgXrxtOlOJIEb7W/IfVxZZ4u95+bqo=;
        b=Wo3hyTqp21FhtTTAM0bym3xouo06DewDXqPPKqX64a/v50JAcakQyj+CU/kTe3gZbk
         6E5Ked2UPLpt4xKb1gw1uVARen9FPCVho3pgebsh4vEP0AG+3S5ikw2IPXFuzAmfXazH
         mbt0k/xUBUtScVKyrD9DGa31BpIF+YiWv2ue7Cl+A2PbPYlIqQcp/C8brX/8QqQYxKKT
         opyKp14l1hOi7C20qY4r1cgXdGoJ4xXNfgNo+zLvI4nau7GxRWP0h2Oxpzh5CwkUUtWu
         YJLqmXsHzZaFYC4MQOsGykTVxQ71TXNC5tJCks7FI3UFZBFUDrasQurhA+KSPv0pE2Uo
         UCWA==
X-Forwarded-Encrypted: i=1; AJvYcCUu1JKbXkwGIr246LsmGumlysyuiqWKXq2wsYwnjW6ITh0a15SaM09TqnCepDF1Qs87mC1q/AIT+kQQx5MnDGXjkcJozvaBwbuKhR8G
X-Gm-Message-State: AOJu0YyIfQXnxaAtFSMATxP3OTaP1rK1l38DkRkRotGtwjZK4K7l7ZJR
	3oLVgdFHEwGxkFUgeb21VA7Am8hBQhsA3burhsEFg+eVNL+FDJjolwuV4YJ028L/bInjvESKXv6
	6ieVTZyxkS2tsHgooc6aTLalgk9tJxU7ROZZh
X-Google-Smtp-Source: AGHT+IGeK6dgxqFFgjk4xeptvd+7a1JVOXy1GhRKD0oaMUJXxGZcYPZIaApdK65tlnPduDc4wy1hnWEc/ndpj12FbN4=
X-Received: by 2002:a05:6214:2a1:b0:69b:1f8d:300b with SMTP id
 m1-20020a05621402a100b0069b1f8d300bmr4083789qvv.30.1712951994075; Fri, 12 Apr
 2024 12:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412053245.3328123-1-jfraker@google.com> <661953c285139_38e2532941f@willemb.c.googlers.com.notmuch>
In-Reply-To: <661953c285139_38e2532941f@willemb.c.googlers.com.notmuch>
From: John Fraker <jfraker@google.com>
Date: Fri, 12 Apr 2024 12:59:42 -0700
Message-ID: <CAGH0z2Hp_tXb1dBUDDbWn8J4VG4E9COBkYdWT3HB2NAHB4tXVA@mail.gmail.com>
Subject: Re: [PATCH net-next 12] gve: Correctly report software timestamping capabilities
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shailend Chand <shailend@google.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jeroen de Borst <jeroendb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Junfeng Guo <junfeng.guo@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 8:31=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> John Fraker wrote:
> > gve has supported software timestamp generation since its inception,
> > but has not advertised that support via ethtool. This patch correctly
> > advertises that support.
> >
> > Signed-off-by: John Fraker <jfraker@google.com>
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Thank you

> > ---
> > v2: Used ethtool_op_get_ts_info instead of our own implementation, as
> >     suggested by Jakub
>
> FYI: the subject says "net-next 12", not "net-next v2"
>
Sorry about that!

I made two rookie mistakes haha. Sending the patch late at night, and
not re-doing my test email after editing.


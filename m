Return-Path: <linux-kernel+bounces-159669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066498B31D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D8D2818ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8045A13C9AC;
	Fri, 26 Apr 2024 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdOJm0S+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E22413B7AC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118430; cv=none; b=FnX8/AySZWtJT9xfsC0P/0d34ISZY7y8Fh+xRTxJTGb+AB9gmYzo1GqKkHOTwu/d12sKEkajigLcqTuZ9ZKeKs0FTN+OOYrAFGqcNqfyigIXdtEXKmxLQhIdvLsklOQjBmr+hA2poQwPWemEBb+nk+PTePXK2KnLTEm9B7j+XzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118430; c=relaxed/simple;
	bh=I4jyXyyAi3QZnASgYGGXmnwFXyQmLri5sJPLHXDrOcE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBut/yQyO3u8BgdzitQj84zW5Ju/ofOOcj78uctVFZJhRBe2iBlVRXozAMf1JE/Bm1I/PmfiDwthDFY+tPpplA+YoWx9rJ4nERIDdn/g29W9aHcw2bTDtpn01UwPTcDzQ7eX2XVMCLlZfYCTqrjaig12Acb9ftELUpgf1IEyzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdOJm0S+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714118428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I4jyXyyAi3QZnASgYGGXmnwFXyQmLri5sJPLHXDrOcE=;
	b=GdOJm0S+V/tIdGxh7uf9oGUN87qJuSHeW68xsSOp0QZmDcretwTgFt4+vfrhuDgH9sh30x
	g07Z7ki3+0frfYtH0vCGDPdROwjOsCecZ9WeJ8thbdWpacXLGXhYezG990xoNHuVDWjBO5
	wL+Mzxacrkzm6kLow5A9rd6i9Ljrm24=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-hTk7tO6ZMK2u6twcdo7SFg-1; Fri, 26 Apr 2024 04:00:26 -0400
X-MC-Unique: hTk7tO6ZMK2u6twcdo7SFg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-349d169170bso242792f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714118425; x=1714723225;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4jyXyyAi3QZnASgYGGXmnwFXyQmLri5sJPLHXDrOcE=;
        b=UnNNqbvI8c4dcicDfDQATyBu4SwRrHSvMSxOHFxKZ2T3cSVbf5y8cP6MkyYL4pSs4x
         89CxgLJO0g2PRYEBUVKz0MFwTBOkM2+Jc1W5JPF7Lbq+z/v2wepfGlf7PHLn9QAuKO6F
         p0qEOJpOWrBDbk832RcRBVIx4InJ5+T3GUvNPOY2JxiGN/yyEex8l/lHt1NfVCKbVVWx
         VCRW/2D90Tcve/jAEmQsWl3snQlNwFToeFZ5TkeopCVQDct/ppQIbFzGVJ4cB8FteABY
         yrrzSmtIutpmHC+yn7mkAchmkVG39J7NLOQQ4qEMMT3H4oJqsl15CXhJhrX/lID9rK4j
         blLg==
X-Gm-Message-State: AOJu0Yw15XPDuna5EH5uYSYRalq0dp6seVckMfdtDmVuWcodYokAz2aF
	Q9uNYsafVUoor7uj3ULWA6EfxI2UWD7MGJOwV4sD3bFPo5l6RcxWytaIM3qCnID1F7E1oKg+7R/
	QjHcXKDrKf10dl4nyCeU0crRtHnKApc5Htk48LFIuhpKnNJXcExTcLtPNrXtiTg==
X-Received: by 2002:a05:600c:4f13:b0:41a:c4fe:b0a6 with SMTP id l19-20020a05600c4f1300b0041ac4feb0a6mr1425662wmq.4.1714118425386;
        Fri, 26 Apr 2024 01:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHypGzVCjg1bdHjBJuqKWUEjN7HuJAcZUK/lMsC9yXEfcn0iXvQrt1R8GqWd50KEebH4BjDhg==
X-Received: by 2002:a05:600c:4f13:b0:41a:c4fe:b0a6 with SMTP id l19-20020a05600c4f1300b0041ac4feb0a6mr1425635wmq.4.1714118424976;
        Fri, 26 Apr 2024 01:00:24 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm29990437wmo.34.2024.04.26.01.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:00:24 -0700 (PDT)
Message-ID: <ab75baa2c972859df01a29494fb17ad4b0cc0bab.camel@redhat.com>
Subject: Re: [PATCH net-next 2/4] net: add support for segmenting TCP
 fraglist GSO packets
From: Paolo Abeni <pabeni@redhat.com>
To: Felix Fietkau <nbd@nbd.name>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 10:00:22 +0200
In-Reply-To: <1bc0ac3d-b18d-4969-a090-6803fa4dd5b4@nbd.name>
References: <20240424180458.56211-1-nbd@nbd.name>
	 <20240424180458.56211-3-nbd@nbd.name>
	 <6629c805d808e_1bd6b029424@willemb.c.googlers.com.notmuch>
	 <1bc0ac3d-b18d-4969-a090-6803fa4dd5b4@nbd.name>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-25 at 09:51 +0200, Felix Fietkau wrote:
> On 25.04.24 05:03, Willem de Bruijn wrote:
> > Felix Fietkau wrote:
> > > Preparation for adding TCP fraglist GRO support. It expects packets t=
o be
> > > combined in a similar way as UDP fraglist GSO packets.
> > > One difference is the fact that this code assumes that the TCP flags =
of
> > > all packets have the same value. This allows simple handling of flags
> > > mutations.
> >=20
> > Can you clarify this some more? We expect potentially different flags
> > on first and last packet in a TSO train. With fraglist, the segments
> > keep their original flags, as the headers are only pulled. When do
> > segment flags need to be replaced with those of the first segment?
>=20
> Maybe I just misunderstood a comment that Paolo made earlier regarding=
=20
> TCP header mutations. Will review this again and compare with regular TSO=
.

I likely was not clear, I'm sorry.

Let me try to rephrase. After the GRO stage, and before segmentation,
the stack could change other fields inside the TCP header (beyond
src/dst port). e.g. nftables can clear the ECN bit, or strip all the
TCP options.

The frag_list segmentation should catch such changes and update the
individual segments csum accordingly.

Note that even IPv6 could snat/dnat a packet!

The GRO stage allows aggregating with different flags. Later on, at
segmentation stage, all the individual packets except the last one will
retain the same flags of the first segment, except for the PUSH and FIN
bit, that will be cleared. The last segment will have such bit value
preserved.

Cheers,

Paolo



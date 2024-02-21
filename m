Return-Path: <linux-kernel+bounces-74987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B685E0D0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C094FB230A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4480BED;
	Wed, 21 Feb 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPze8jVi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8876180610
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528767; cv=none; b=YSFiUb9kwrxO+ae8fwEjM0M3facXE3KAh1SeQdLXuIB28VecPtlXnIrUSdbYlJoE30BXWERW3TiajyBmxwvyOSa6t90HQNTN5KbFwTfgaeeV4w9JJUeCH8MuDh5kZGAx4PiBtmy7vmUZLUsBm52KMyTpjlf7GL1FEHcMnJhoMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528767; c=relaxed/simple;
	bh=aqrE+ffOCBnSJ/q2JwD2my87yIyHGcBKd1rdKGerNU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MzYDJ/YvoObdSioSm/oBquMMEPsj1eEmlRtd8FzUQ/aZDn2vKGkSyUZwjwWyKNn/LPWNMEO30nqgr8XRjXtufwfy+bV/AVsrtz0E3d3hbpxqVwY7GGwTNGgKqucMCQ3tG/hFYHO6mvc/+x2qco9AjXkwWYvH1Z97YgdgyME446w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPze8jVi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708528764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AD0dqliRQF6GMDe72qQKbpcVxfavw6j6tqjQOUIDgdU=;
	b=YPze8jVijCZHlPQvqkiJYIIWPYxmbbQ0g8X86eXFBCpsyOREDNGrEBuS/gn8fNW8WU5Ssz
	KCb6t87HEMhe15DRY6z1JcdJQK3LqIC6oR2fSZx/IRYTt4faafxwlkuoMNiY2u5uYY4zSg
	BJ95hZ1ob0SUoyKD46Gr4nWnShGdUs8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-5Va2c57cNHu0RmDrtqtYDg-1; Wed, 21 Feb 2024 10:19:23 -0500
X-MC-Unique: 5Va2c57cNHu0RmDrtqtYDg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d86aedbffso31151f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528762; x=1709133562;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD0dqliRQF6GMDe72qQKbpcVxfavw6j6tqjQOUIDgdU=;
        b=PPwW0FoonyM0py+TmGYpf5USABbKhowNmqArgcIfRk6s++lzHGW+fe8xSJnDpnQW3R
         pVY3BjhOh9ZxF6jwtBwpJJOMnh2Y1Ck3FcVBzTFLIfHDQUPZhkJIYtdE81rkDOl1PTU8
         mbjBxymOjnFfWsvyhTlH73CGByUnjfcr+0oF7W9GZeTmm4jKY6K3cxZFOEMqcUgGcgGz
         /EhcISC9GMO6YzfteVo2QYsDjKbv9TVs6tfqEQP4RwhbkCJpTgp7mV1l37/NSPCxeZl7
         J25+ynzcU5gn57UD9fsR14HNJXRVSlhcZB9mL9TAoyAyFIDdKim/fSGBzexsOnGx+80o
         8MLw==
X-Forwarded-Encrypted: i=1; AJvYcCUxRNrN4iObLmfDbtfHpkQihgVJq1/e+wv5F/VCuhMQBw0QKOsrhs0pdBlT3p1PKWrqmZZTHt/LOEJhm86nxc8AOeVSQ+S2T2FzDH0v
X-Gm-Message-State: AOJu0YwDsl+1e1Qu395WDA6eCUT7t137uRoujlphaI6WmIktdyo6XW/A
	cf6IRz8SWvB4PjqmOc/mniE9bBOSCYvDakkzXH8Huoz4rGs4ipveZDMHPAmV0DEWBwywwMI8kDe
	QtFVdOZCSSAOSvC50Gg2M3vi3vrl/p06+vBIr5DeDvq043rP43nv4Az850E6iDg==
X-Received: by 2002:a05:6000:702:b0:33d:5803:1934 with SMTP id bs2-20020a056000070200b0033d58031934mr6469304wrb.5.1708528761946;
        Wed, 21 Feb 2024 07:19:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhjo8T9vOGB1bgW4e83glaOl4doSfkw2/URnCXCpSnJFJNR4dfcmlzTeyQ9sEtS10XAp2Hjw==
X-Received: by 2002:a05:6000:702:b0:33d:5803:1934 with SMTP id bs2-20020a056000070200b0033d58031934mr6469281wrb.5.1708528761565;
        Wed, 21 Feb 2024 07:19:21 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-226.dyn.eolo.it. [146.241.230.226])
        by smtp.gmail.com with ESMTPSA id by15-20020a056000098f00b0033d7920fe09sm2898575wrb.2.2024.02.21.07.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:19:20 -0800 (PST)
Message-ID: <90f9d3056554c9b318baacc5000b1ae02b59d8f4.camel@redhat.com>
Subject: Re: [PATCH net 2/2] selftests: mptcp: explicitly trigger the
 listener diag code-path
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Geliang Tang <geliang@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
 mptcp@lists.linux.dev,  linux-kernel@vger.kernel.org
Date: Wed, 21 Feb 2024 16:19:19 +0100
In-Reply-To: <1116d80f808ea870f3f77fe927dbd6c622d062ae.1708515908.git.pabeni@redhat.com>
References: <cover.1708515908.git.pabeni@redhat.com>
	 <1116d80f808ea870f3f77fe927dbd6c622d062ae.1708515908.git.pabeni@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 12:46 +0100, Paolo Abeni wrote:
> The mptcp diag interface already experienced a few locking bugs
> that lockdep and appropriate coverage have detected in advance.
>=20
> Let's add a test-case triggering the relevant code path, to prevent
> similar issues in the future.
>=20
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 30 +++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/se=
lftests/net/mptcp/diag.sh
> index 60a7009ce1b5..3ab584b38566 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -81,6 +81,21 @@ chk_msk_nr()
>  	__chk_msk_nr "grep -c token:" "$@"
>  }
> =20
> +chk_listener_nr()
> +{
> +	local expected=3D$1
> +	local msg=3D"$2"
> +
> +	if [ $expected -gt 0 ] && \
> +	   ! mptcp_lib_kallsyms_has "mptcp_diag_dump_listeners"; then
> +		printf "%-50s%s\n" "$msg - mptcp" "[ skip ]"
> +		mptcp_lib_result_skip "many listener sockets"

I was too hasty and this is too fragile/requires debug. A v2 with
something more reliable is needed. Given this is not going to land into
this week PR, we will probably send it with a burst with other fixes.

Thanks,

Paolo



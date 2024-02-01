Return-Path: <linux-kernel+bounces-47944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 890FF8454F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BD61C24FF8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFC515B963;
	Thu,  1 Feb 2024 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBGZvDRN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84634DA06
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782548; cv=none; b=DQ10hl2j0LS0k8uAMSulB0g/4f2MtKWgbqhhyzY2+GJvC4ye8ejaXwsC+bEzXxYiFoxHM1HN3v5W2bmqrCtC9IjlWiKPip3RAl40J4W7AUixKoUXKxi3Ar4ouVYN45N3ALd1Lz9yvZjD97BJpwc3FG10zDIvTNAfIKBbN3oI1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782548; c=relaxed/simple;
	bh=3ID2uCtb4Y4CtF/q1Ub7GNbGzzjPChqq2Er1VkwdvDU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=asWA4mP+k2Od6FXIrKHAhuTCrh69GhlKtyEpKNpGkcn64JdUf7V8dt6cFQvELVbQisbgrF2mZ4RMPYtmCqM/nbiG9Gsk4Wz0r89/eRXU80hAbdHtJikTcOeXPkv+9dHvg/Xu/mpwvmAEzyy0J0eb+WIOxj9fI8+2Y7D4PjNA4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBGZvDRN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706782545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3ID2uCtb4Y4CtF/q1Ub7GNbGzzjPChqq2Er1VkwdvDU=;
	b=MBGZvDRNWKmHGbnmFIf9LMP1t3SWAcG1RZ97VAnZSqEUq/s/qalypFcGQFSVzTehYyRP+D
	H73Hi7q89H/WXPeVOPe4E2jMrGFozxEn3X/Iiiy4yt3Q77JLmwxfY73Rk4cRXm8zrKUIVd
	EaZisorwLhumOOaMV4JDcr1gkRb7yp4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Q-lEmN1FMCWDK5sR7wFSZQ-1; Thu, 01 Feb 2024 05:15:44 -0500
X-MC-Unique: Q-lEmN1FMCWDK5sR7wFSZQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40ef29ce877so458935e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 02:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706782543; x=1707387343;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ID2uCtb4Y4CtF/q1Ub7GNbGzzjPChqq2Er1VkwdvDU=;
        b=WF0jTiStSETSZeWrcVGPdmX0erYBmvExjoAFFqSzwlMQcGeZZh3rJcH/01vXeR6wxA
         Al5fHs5/2zrSfmn0nXhYfD6GxbKt6v0VWRr1ejYZ8sVQGlSfk5o5Zh1d7ovVWBw9AR+4
         KWTgrUT1ABAowrGAfRFpcJUdkNTdROVU5DQC1OYaChFs/kKru1Jy6jaBjlEnqy8jVgSb
         iZW6kmI3bnfuE/Dbh7vNqVHC1n/wQ2+ks9JSnVm+kCQjNHfsriiDlA1EaLPMNc5527Ly
         xalX4MLKgQvEu9z3T7/FIjM374+Uji8wyhf9cEzzcH0Rh8BtGcqmWe3PJg0la2+j4lF2
         G0kg==
X-Gm-Message-State: AOJu0YwfBc16uJD+1cMin55nX9Ln5757m4EQjpoJlHpdyRZgmkeF/7Rl
	+qw8VKgxgNOv5YuCRsWZNt2TQeZhqTG32rnDn8EW0uwMIIDeK7P0ndTQrua/bbw3jvf9Fcby/R2
	3mmyqvNOlNpWClXEIO6AUZC+o8J0G2vuXZzF4VJAsZlDd2ZWF54tK8SAu1jwy3A==
X-Received: by 2002:a05:600c:1e87:b0:40f:afd7:47e0 with SMTP id be7-20020a05600c1e8700b0040fafd747e0mr1775571wmb.4.1706782543068;
        Thu, 01 Feb 2024 02:15:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIN8sELgFG0b50uIS83BbIkr+z+YFBvq48pITAvDoN/i1qirlHS/3aaKPLIzW42LDymMl3cA==
X-Received: by 2002:a05:600c:1e87:b0:40f:afd7:47e0 with SMTP id be7-20020a05600c1e8700b0040fafd747e0mr1775552wmb.4.1706782542739;
        Thu, 01 Feb 2024 02:15:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-238-90.dyn.eolo.it. [146.241.238.90])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bc04a000000b0040fb01d61a3sm3888196wmc.18.2024.02.01.02.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 02:15:42 -0800 (PST)
Message-ID: <15d7f2941394e04d45f98aa6d095b1e07262655c.camel@redhat.com>
Subject: Re: [PATCH net-next v6] bonding: Add independent control state
 machine
From: Paolo Abeni <pabeni@redhat.com>
To: Aahil Awatramani <aahila@google.com>, David Dillow
 <dave@thedillows.org>,  Mahesh Bandewar <maheshb@google.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>,  Andy
 Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 11:15:40 +0100
In-Reply-To: <20240129202741.3424902-1-aahila@google.com>
References: <20240129202741.3424902-1-aahila@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 20:27 +0000, Aahil Awatramani wrote:
> Add support for the independent control state machine per IEEE
> 802.1AX-2008 5.4.15 in addition to the existing implementation of the
> coupled control state machine.
>=20
> Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
> the LACP MUX state machine for separated handling of an initial
> Collecting state before the Collecting and Distributing state. This
> enables a port to be in a state where it can receive incoming packets
> while not still distributing. This is useful for reducing packet loss whe=
n
> a port begins distributing before its partner is able to collect.

If I read the code correctly, the transition
AD_MUX_COLLECTING_DISTRIBUTING -> AD_MUX_DISTRIBUTING is not possible,
am I correct?

Any chance we can have some coverage via self-tests?

Thanks,

Paolo



Return-Path: <linux-kernel+bounces-55591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B1F84BE99
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCD3289097
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CCF1B950;
	Tue,  6 Feb 2024 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJHldAVL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5021B948
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250913; cv=none; b=Ay9c1ui0ab5MJe4qfX5pVAePJ1x4oTgg6N6X/qkZ72D/9GEkwNNxAsYxc/kNHWeWineWF8AeZ0kjPUcgGKQSrtaQ77xdfPcLm5pfc7v9ksGM1bHejeQzXfnVHZt4KsYNWWAH3/KnP3VweXLNYwgtmw6m8FWOx9Ehr8pgdL166ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250913; c=relaxed/simple;
	bh=XBWmAmkri8oGzz9joCMe1mu+RV9zbBFo6r7zAXZX7DA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kOfOp2hNSRPy4J3FzhByGW6svVDi87rr82eOHkRhfPuw7p3dl7nLn7xSxx7OyvH9fEF5K1Vt2/ZWyu5l9AJxOcOk09VG1VZ7r9AzTk37Ixi3ArziFJ3HISaJPB7oBv/+friej6Kr+tokLhPSomrFuppBbz2AHeLpQZi1sd6LioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJHldAVL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707250911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBWmAmkri8oGzz9joCMe1mu+RV9zbBFo6r7zAXZX7DA=;
	b=TJHldAVLYE+AZmnEB3TJmRJ2wk9M+D5l5nIsUHRCqVBf4SU+uj/jD2QoSUk0uSaOXsi8oV
	G44znxurO5Apwts+KArOOy8+lv+dxliibQ9sm20zxAolaS7vXQe6QNYxXFErQMRTgdul/v
	WJpcUFeIhZlnQLl24Xd8N/UORVgJiZY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-J1AU3HN_MCWLcQjPSeitAw-1; Tue, 06 Feb 2024 15:21:49 -0500
X-MC-Unique: J1AU3HN_MCWLcQjPSeitAw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-560aece3ff0so162613a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 12:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707250908; x=1707855708;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBWmAmkri8oGzz9joCMe1mu+RV9zbBFo6r7zAXZX7DA=;
        b=J+W607m04bCtus4iNAnKNRv4KPucmzsSEY0KlYaYLoYR0szSqB8S2tdis+JSF892LA
         ZNttw8mJJivSuVS37dqbqEmQrcDC1L7x043NoeTCkPv3epzk7fPgDiVBboGNM27pXm9o
         G/6Z6HYP7Y26BoVLn9z4BifmGYpjDt2oW2vqMjHpXcrTrUBRGZ5XiU2UWZnI9ikyj93x
         h2YGyHZqY6CbmfmNNx55Le36pXBGbiMmF2iyInHgORgLzH2VfvR1lkOUw/F9ZHqP72t1
         MOKS2mOcbUOXCYH5x4PzQeMLZfA3AhnewhOeqhI2gouUqFbziXrFYrE1n8Xo4iNOmWDt
         dmdA==
X-Gm-Message-State: AOJu0YxDqMQvP0pNJ2qetrhOiaBok01CzG8S0PIJ0jqENGs3KA0q0+/u
	ClUFANjBqAXMPQhJtvxLYEiLLVUVuDLFr5qWzqj2NkYn6UNQvgEFIYhlNCiMFZ49Zl29CKRQ20G
	WAHHaC7LursCh6R5LV6WLECJC9/YZ/hHdWWvbvkNJeWsebpRqMyETxIkF2yYlZA==
X-Received: by 2002:a17:906:2b19:b0:a38:5b7f:b673 with SMTP id a25-20020a1709062b1900b00a385b7fb673mr348018ejg.7.1707250908461;
        Tue, 06 Feb 2024 12:21:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgH1bFgAtBqJlRy3+oSc4XtCzivAFTBXnopeTApaCZxTD1IEmbH4z95JawoIidreeGHLD73Q==
X-Received: by 2002:a17:906:2b19:b0:a38:5b7f:b673 with SMTP id a25-20020a1709062b1900b00a385b7fb673mr348015ejg.7.1707250908129;
        Tue, 06 Feb 2024 12:21:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVouwe8cl9sV3zX4so5DXsOAo+saYq6Gxv2n4iq4W0nk34RQ66TplBrUxdo03z36kuLX4pKZ03pJeUwQsLV7kA3gRQd+lypGSO/JROj6aVAzOTGC0dpWMLCNYM0eOU7yUiSTlwjaUBvMtnHHeAFbOAVnIebslSJsmP8AeD3RDB/WZTibVI=
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32d4:ad00:a792:8bcc:713c:8e46])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906381a00b00a37116e2885sm1528388ejc.84.2024.02.06.12.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 12:21:47 -0800 (PST)
Message-ID: <1aab79c05e0192e5e2299586591517e134c37575.camel@redhat.com>
Subject: Re: linux-next: build warnings after merge of the pci tree
From: Philipp Stanner <pstanner@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Bjorn Helgaas
 <bhelgaas@google.com>,  Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
	Mailing List <linux-next@vger.kernel.org>
Date: Tue, 06 Feb 2024 21:21:46 +0100
In-Reply-To: <20240205160908.6df5e790@canb.auug.org.au>
References: <20240205160908.6df5e790@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Mon, 2024-02-05 at 16:09 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the pci tree, today's linux-next build (htmldocs)
> produced
> these warnings:
>=20
> Documentation/driver-api/pci/pci.rst:27: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:27.
> Declaration is '.. c:function:: void __iomem *pci_iomap_range(struct
> pci_dev *dev, int bar, unsigned long offset, unsigned long maxlen)'.
> Documentation/driver-api/pci/pci.rst:27: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:27.
> Declaration is '.. c:None:: struct pci_dev *dev'.
> Documentation/driver-api/pci/pci.rst:27: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:27.
> Declaration is '.. c:None:: int bar'.
> Documentation/driver-api/pci/pci.rst:27: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:27.
> Declaration is '.. c:None:: unsigned long offset'.
> Documentation/driver-api/pci/pci.rst:27: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:27.
> Declaration is '.. c:None:: unsigned long maxlen'.
> Documentation/driver-api/pci/pci.rst:67: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:67.
> Declaration is '.. c:function:: void __iomem
> *pci_iomap_wc_range(struct pci_dev *dev, int bar, unsigned long
> offset, unsigned long maxlen)'.
> Documentation/driver-api/pci/pci.rst:67: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:67.
> Declaration is '.. c:None:: struct pci_dev *dev'.
> Documentation/driver-api/pci/pci.rst:67: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:67.
> Declaration is '.. c:None:: int bar'.
> Documentation/driver-api/pci/pci.rst:67: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:67.
> Declaration is '.. c:None:: unsigned long offset'.
> Documentation/driver-api/pci/pci.rst:67: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:67.
> Declaration is '.. c:None:: unsigned long maxlen'.
> Documentation/driver-api/pci/pci.rst:110: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:110.
> Declaration is '.. c:function:: void __iomem *pci_iomap(struct
> pci_dev *dev, int bar, unsigned long maxlen)'.
> Documentation/driver-api/pci/pci.rst:110: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:110.
> Declaration is '.. c:None:: struct pci_dev *dev'.
> Documentation/driver-api/pci/pci.rst:110: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:110.
> Declaration is '.. c:None:: int bar'.
> Documentation/driver-api/pci/pci.rst:110: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:110.
> Declaration is '.. c:None:: unsigned long maxlen'.
> Documentation/driver-api/pci/pci.rst:131: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:131.
> Declaration is '.. c:function:: void __iomem *pci_iomap_wc(struct
> pci_dev *dev, int bar, unsigned long maxlen)'.
> Documentation/driver-api/pci/pci.rst:131: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:131.
> Declaration is '.. c:None:: struct pci_dev *dev'.
> Documentation/driver-api/pci/pci.rst:131: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:131.
> Declaration is '.. c:None:: int bar'.
> Documentation/driver-api/pci/pci.rst:131: WARNING: Duplicate C
> declaration, also defined at driver-api/device-io:131.
> Declaration is '.. c:None:: unsigned long maxlen'.
>=20
> Introduced by commit
>=20
> =C2=A0 fbcc7d7f7948 ("PCI: Move pci_iomap.c to drivers/pci/")

Oh oh =E2=80=93 Mea culpa. Will fix this.

I'd just ask for some direction how to fix it. My instinct would be to
just remove it from device-io.rst, since it's very PCI-specific; What
do you think?


P.

>=20



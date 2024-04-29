Return-Path: <linux-kernel+bounces-162859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DA88B6168
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB3B281577
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DA213AA3A;
	Mon, 29 Apr 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRKRu19V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B2127E20
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416634; cv=none; b=gb1cvfjxdwRAtuKM8Xkf+y8L8IxMZCuBxdysGMvbtaAzUcAOxcRKMjnHDF8Thhq0D35HzTKbm1uAwsZGZrqCG26cnUpdt/uHfteZZki9nnaSJtvAepL8IOdjgFDckWEZCTFpb3ddbwihjh5rOcq086JGTgm2wif8GPw3vcnDGMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416634; c=relaxed/simple;
	bh=4BM15V5T8ZCJlfeNEJbWlVWcJsEzsXEXtP5ugGZF6aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT9S2G1akUaN8Z821coUGjyPa7PWtOtOtQXyBQueV0UvNYlRDJdxbB/YvY0w/wDylsE5E9dpurb3oyv4QtCvvifi7YMqrLe/iMw8T5Sdo6uu+eRxQl14R3c2iBeAELoSu+FmvpBoFW/gzbZX5m59J9vOk8qa6HtHhm3nQn1S6lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRKRu19V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714416631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/isLP1aYjVL55Cg0kF6I/0JVsi7H8eKx3IvIq+SH1r4=;
	b=cRKRu19VbqSMm5ae7cxlxcFu4h3uJdv5eZrmPeuOzvWKDItmvwUwKQPEgI6yMeDgNYOwOB
	4wa81Hek45lbV4SHIp6f4QSxYe5kUqhOBDQRpKiTOWJMu0WdFyX3++yNV2wTDJWQxHRTC8
	6uVkTi+VisbPGAE/n4RnVjjfJYr7w7c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-xcDcqx9qPByo8W4q8nWSbg-1; Mon, 29 Apr 2024 14:50:29 -0400
X-MC-Unique: xcDcqx9qPByo8W4q8nWSbg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34d1089a3feso710312f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416628; x=1715021428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/isLP1aYjVL55Cg0kF6I/0JVsi7H8eKx3IvIq+SH1r4=;
        b=S5lKQMa3BwVy6cNeTVht5ww8YByC7yaBHP/nwZCAOqlWSgjnZchhxkgi/y7Iy1QkqD
         YM0w+CYa5sEzVdZ6BpRN78J1AoqQZgl06LonJO57Kgct+XeLrVkNrs+JdDrclrpLlCLX
         ewDzGYCTbfmK17oAf6g9Wsjtbxbtx1wD7kVWFvUfHAflSLP7MNVcGNmsXp5rb2oLHKiL
         A7FdcYxLWpnivxR7fMJKAILx58la8MHNcPlZQNw9hmuSe5dlWNPozzQAk6EgxmZMHPow
         kiMplmsZ8k/pdk/j0LUOBQDKA379KJ1vTtsymYxeIRtOLdVx0rI57dr7GbZsCNK6BMU5
         MjWA==
X-Forwarded-Encrypted: i=1; AJvYcCUKiJ12Q4+O/iyvCAuxyARUFw2Mbq8JBbHlSfCvf8FGeNqK7BQl/HcKC9THO9mWiFG2+jITHjCfKK9WmE7ANmkh4WUVHVZkvuz+uQEH
X-Gm-Message-State: AOJu0YwfH4IILuT14EhskenY/KY1uZdHRycEKgaRaPmpDIIzUvvRtvD0
	/xBBxVM1t39SHmd/pw1KXh2+B9FCWVyvsi4YYijbA8ZuhyfhSV/YoN4kxmo1DbdaKfIOHngdEVg
	/C2P26lOq8Y2nRaMhcUfGcGVwMq2J9qrdyGWnZrQilvaFqundTOFCcDKA5W/3mQ==
X-Received: by 2002:a5d:47c1:0:b0:34d:1d09:f06d with SMTP id o1-20020a5d47c1000000b0034d1d09f06dmr3471558wrc.13.1714416628182;
        Mon, 29 Apr 2024 11:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCS6P+mXwyMYwBiy2uI9J8aurHOzbMg8kg0FzOrjkGy8BER+E7fyt9B9XmUL3CPWbTmJMWgw==
X-Received: by 2002:a5d:47c1:0:b0:34d:1d09:f06d with SMTP id o1-20020a5d47c1000000b0034d1d09f06dmr3471538wrc.13.1714416627641;
        Mon, 29 Apr 2024 11:50:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:67cc:7d0:12ee:4f8f:484f])
        by smtp.gmail.com with ESMTPSA id s11-20020adf978b000000b0034d0a64ed0bsm3592659wrb.77.2024.04.29.11.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:50:27 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:50:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2 0/4] vhost: Cleanup
Message-ID: <20240429144955-mutt-send-email-mst@kernel.org>
References: <20240429101400.617007-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429101400.617007-1-gshan@redhat.com>

On Mon, Apr 29, 2024 at 08:13:56PM +1000, Gavin Shan wrote:
> This is suggested by Michael S. Tsirkin according to [1] and the goal
> is to apply smp_rmb() inside vhost_get_avail_idx() if needed. With it,
> the caller of the function needn't to worry about memory barriers. Since
> we're here, other cleanups are also applied.
> 
> [1] https://lore.kernel.org/virtualization/20240327155750-mutt-send-email-mst@kernel.org/


Patch 1 makes some sense, gave some comments. Rest I think we should
just drop.

> PATCH[1] improves vhost_get_avail_idx() so that smp_rmb() is applied if
>          needed. Besides, the sanity checks on the retrieved available
>          queue index are also squeezed to vhost_get_avail_idx()
> PATCH[2] drops the local variable @last_avail_idx since it's equivalent
>          to vq->last_avail_idx
> PATCH[3] improves vhost_get_avail_head(), similar to what we're doing
>          for vhost_get_avail_idx(), so that the relevant sanity checks
>          on the head are squeezed to vhost_get_avail_head()
> PATCH[4] Reformat vhost_{get, put}_user() by using tab instead of space
>          as the terminator for each line
> 
> Gavin Shan (3):
>   vhost: Drop variable last_avail_idx in vhost_get_vq_desc()
>   vhost: Improve vhost_get_avail_head()
>   vhost: Reformat vhost_{get, put}_user()
> 
> Michael S. Tsirkin (1):
>   vhost: Improve vhost_get_avail_idx() with smp_rmb()
> 
>  drivers/vhost/vhost.c | 215 +++++++++++++++++++-----------------------
>  1 file changed, 97 insertions(+), 118 deletions(-)
> 
> Changelog
> =========
> v2:
>   * Improve vhost_get_avail_idx() as Michael suggested in [1]
>     as above                                                     (Michael)
>   * Correct @head's type from 'unsigned int' to 'int'            (ltp@intel.com)
> 
> -- 
> 2.44.0



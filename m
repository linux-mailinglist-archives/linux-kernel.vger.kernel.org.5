Return-Path: <linux-kernel+bounces-107350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031187FB55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF27B282D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39887E78B;
	Tue, 19 Mar 2024 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVpg6SZ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF547E781
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842078; cv=none; b=VdG7f5oJ4VMsy8ZE8nD50rr4Ux4wYEdddzaUtGKCVcPZcguUgVNVppsWS8Rox3JTux8OKqU8MQcByPBbMQPIPea0RbrVWv4zvG5NfF8FtzsE73SwLK2T7nMF/w6jBf5PAQZf1OBR3A4wax485LBbqWuf9gElsb8vO5e83F+d6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842078; c=relaxed/simple;
	bh=uNDPpDP7QY+YDybRpdn+O7fkHlUVRWgPRu7fk5G//RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVTTQleoWDbGKixateDQlBOiNGU3K26kEuqsQvrJvOCL0ry36qomgt1TzNYMnX/nNSFjuEbxdXxO3NNLraEDylEZkTFhZWquiagzTSdh5H1XALx5p8ZY/OuVdpTXyAHTw4y16epgbuEhiMk3sf4ehaJRLdO3JKGCIxlz6/6YaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVpg6SZ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710842075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hib0zDgjX0wwE4G3s6Q4ROR6T+E9FLihqyZ1EtpwmMY=;
	b=QVpg6SZ+HrL4CHeg0VnD09S8JWbqPp0P9jpc9NHerFJV72l2xJhqUkW+oHhh0aaX4wUQnD
	tmOCXv0cZLmb5eIlwPEvWgtAq9Vd+lLzYZNGiex10MtAyTC856iqChOg5MT0XAGhYDEH83
	W1CYiQDLzaddFDXRLk30kKhx2+ta9Bw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-RjRN7pEAMvOcmi4-Fq7OTg-1; Tue, 19 Mar 2024 05:54:34 -0400
X-MC-Unique: RjRN7pEAMvOcmi4-Fq7OTg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a467a6d4e3eso250663866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710842073; x=1711446873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hib0zDgjX0wwE4G3s6Q4ROR6T+E9FLihqyZ1EtpwmMY=;
        b=rVXMDNtixggp5eEDO9rRo69zde3szGrbU2lok9Ho2397ey+A5XdfWDPqsT2QX+HV5q
         SaMuDwcfDso/ZSuakzOyw3NCbu1xwiIHLq3/bF0JTkl8XNaGDjEdHbrbe9KKIn2M7csJ
         KO2KTeyiajaMp/HIh/VSqnytC25Ij7kxrZa7eY1TxaYYdjYo6OREBHTmKSmbeaM3mD54
         2SgcdjYA1VH2xsT6hpgMWdj6Kv0CwyH1qiIhhYvCtskgutkP5iXWaaiYNGXhx/GxYK77
         8SbCmOyXVlbD94rgdMH1A95T82o8WhB0QQD4uujTP/yGdO0fxw5YvtnTHYtCqpTePDlG
         iskg==
X-Forwarded-Encrypted: i=1; AJvYcCXhGySkCZNsduwO+8AKgR0m4N8HZ2kSOlJoMsm/cNlYB0rWY8vnhFv643NbsWQMqF7KsAi6oSmSij4kGMzLUqWr7RO17Gfxo70sYX2s
X-Gm-Message-State: AOJu0Yw5fiGT2vhDehH+Y0P6CmeavKsgW2+K3560KhyrCgau8Hhsgw/i
	jWbq1D709gONLpqMhy9QhGVJzinRpTivpgOtVvJyS+RNPy6zaKMjO4bF8G7wWuBNLdvtGURMFXT
	mM8oZw1GQo9T9dDrl6pZCxjIPhb9U7fSngHB106n/mXehMxtkVEwzeLE1LQ9SZA43V6UF3ixVye
	rpe1P4keHVFFZ/2JfM5vxSqDqVmB1kcSf+/leS+itAMhls58U=
X-Received: by 2002:a17:906:2310:b0:a46:7e08:37e8 with SMTP id l16-20020a170906231000b00a467e0837e8mr1225437eja.53.1710842072873;
        Tue, 19 Mar 2024 02:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6BjyEnKy2Dpuf1Q6n6FNGZtdfuIfYcEAZFAZvpsZOgYjjHe0uXoAnkUBurhDlGn2w1OypmrxEZKsO7bB1uBs=
X-Received: by 2002:a17:906:2310:b0:a46:7e08:37e8 with SMTP id
 l16-20020a170906231000b00a467e0837e8mr1225428eja.53.1710842072689; Tue, 19
 Mar 2024 02:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318143058.287014-1-ivecera@redhat.com>
In-Reply-To: <20240318143058.287014-1-ivecera@redhat.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Tue, 19 Mar 2024 10:54:21 +0100
Message-ID: <CADEbmW02H_6h6cdXher4Ua_ZzTduF_gF-b8ADRSamOms--HZbQ@mail.gmail.com>
Subject: Re: [PATCH iwl-next 0/7] i40e: cleanups & refactors
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 3:31=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
>
> This series do following:
> Patch 1 - Removes write-only flags field from i40e_veb structure and
>           from i40e_veb_setup() parameters
> Patch 2 - Changes parameter of i40e_notify_client_of_l2_param_changes()
>           and i40e_notify_client_of_netdev_close()
> Patch 3 - Changes parameter of i40e_detect_recover_hung()
> Patch 4 - Adds helper i40e_pf_get_main_vsi() to get main VSI and uses it
>           in existing code
> Patch 5 - Consolidates checks whether given VSI is the main one
> Patch 6 - Adds helper i40e_pf_get_main_veb() to get main VEB and uses it
>           in existing code
> Patch 7 - Adds helper i40e_vsi_reconfig_tc() to reconfigure TC for
>           particular and uses it to replace existing open-coded pieces
>
> Ivan Vecera (7):
>   i40e: Remove flags field from i40e_veb
>   i40e: Change argument of several client notification functions
>   i40e: Change argument of i40e_detect_recover_hung()
>   i40e: Add helper to access main VSI
>   i40e: Consolidate checks whether given VSI is main
>   i40e: Add helper to access main VEB
>   i40e: Add and use helper to reconfigure TC for given VSI
>
>  drivers/net/ethernet/intel/i40e/i40e.h        |  29 ++-
>  drivers/net/ethernet/intel/i40e/i40e_client.c |  28 +--
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   3 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |  36 ++--
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  29 ++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 199 ++++++++++--------
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   6 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  16 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   2 +-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  14 +-
>  10 files changed, 210 insertions(+), 152 deletions(-)

Series looks OK to me.
Reviewed-by: Michal Schmidt <mschmidt@redhat.com>



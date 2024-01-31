Return-Path: <linux-kernel+bounces-46392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B85843F02
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258CF1F30DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D245A7690F;
	Wed, 31 Jan 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uPz8u/DH"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F179768FA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702412; cv=none; b=B/9hh37J8MxmP+UuqZcCRHFLVSW/6g/XwJqBJeb7p7cjqqNfS9VrhwzrbaCQa9Qb7fqz8qB9VsURYJgKq+Sg0P215zcxj8E71kPrdO1+mlgpFNDd1rW6hXmv1dbegBi1HFEekVfU4F2x0RNhfd6CZVgX+aX03cn8pqlq1yiTUOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702412; c=relaxed/simple;
	bh=mbaGmg6mYMDAv6U0bRENMo1BCyzpuN1OGZkDhvhXR0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeNBgmvKSfAr4rzRoXbQYPiUxW8AjJhZsqYRMBsifsHiPvD0TrVmi80Lny+wo13fL2vxNwL9J61Nb8F982h1Q1VTs4qK8MGgkHa3uc75NRQy4UY9K5aJB13V/dz2qQgJITKxmQCwK4GjiqXuF9kv0NNw1KQYMgKwBg7Mdcl37Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uPz8u/DH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ae3be1c37so494003f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706702408; x=1707307208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HRIlhUmLDjTPjpQJWhot1CNU7PKVSI6pop1UZB6zBPk=;
        b=uPz8u/DHZEW7QjqmfmPZUKoTFrDZJRlQYAfRuxN4zsvBBZc5t3d+y8z9mYhMNE+TCA
         28tP7hYJ4hBpANJsjAhVjSfC0ghdnC33MduTWnylpBJ0wgRA8lTFIttN8ABd+hUf+Eul
         o1XUXwa9xxdJEsKfSwyoF1ICmPjw9Mf29y335BT3HlMp9K2KVnXRkgFThV0Q79Jeh73I
         +N0WCzmGjgPWmbMQIqAsIwZtRUAXUUfSckx8wtyTmS7Ia2n5mKJSj72M9thSdEWdwBQ5
         sUS4qsWraTr7Ep4ZwKg8q5fVFi1ztPG8iKtmlxFVIUxJMdt0vHkt4YTAciD9i5nbyRor
         I2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706702408; x=1707307208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRIlhUmLDjTPjpQJWhot1CNU7PKVSI6pop1UZB6zBPk=;
        b=tHYmZRFW811hY+j3T/wr+0dNJmURTaG+l7JUHXDOz44+V/J8b2r9BMfWinIxlepINv
         MVujkidgik/vmzZKf4MnGdBaR0NuWHhfrn7XIYvdw0XEPhwGzdL5lBvQk+78VVw4Sz7L
         4k+h6Y6hhOEfNnvkEZmMzzrwGzhlu8q5m1bEMme4Qd+vpwHkKKCjYS6+vJ/1vRkOqwUM
         GRKkswtnXQ68yVDVRHq65cS3jjtuJDIhs19J6S9zWMmCkoo84GcCcuxPk27XQM+YtFux
         M8gBFqG+TXpRRdvqAY6cr6kIyjei22AJy9YkMV1+VDlYrzuWwag0encZIzwcIZplhf9c
         Zeog==
X-Gm-Message-State: AOJu0Yxicz1qGgbUfWDKUmPWfDq/l0yaL1XAputyWF/qP5sxFGiQVh/c
	PrksGgmvzgJJlm6FGRf6BwkQh/vNoF2merb9NCOclDThCnUR8B2TbubragZhyDs=
X-Google-Smtp-Source: AGHT+IE/gZETgx51O7pzrCc3cEr494HTU9XfJV8azb9nJPzczdS5zJhegdsdVTGJc1Cb3wC4htdFyQ==
X-Received: by 2002:adf:dd8b:0:b0:33a:ded0:c309 with SMTP id x11-20020adfdd8b000000b0033aded0c309mr1288727wrl.13.1706702408470;
        Wed, 31 Jan 2024 04:00:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/uzCB3VwH+x4UZ0/JI+iYwp4TEf7h9P3oHFQu4kmLs2PpqfRUeMAuxSO2exbX8NFFnywp9GbXo9B0FY00u6gCHLamjEQFCckgF5FkQjjJtzeQxXC2AJxKfNm78BC6gqliQ9xHevRjGoOQ33Z5xahTB0cofWFeJ42FqQQFHCd2w8Kl2roAuskO5t/99Y49u1DiRdjrujfdB61Wo1J+QrPFK6s/SbDz86ixx+uyLMrCWo6z195T4OBXWsW5q2RYnQI5OODIvHQIn7Leh3JBndKSfm9r1xSISWUbihBsp3Pno0GQuIAxX8+9z1ip5PFJvmp9gGjnE0RUCIWuxPyCL9/CLzVg1Zqgjx92LA5FCZgDZFh2y1LYIV8ZVQStOu4/oEqFX8+K7Nrg9+fFdNiX7xmDig3ttLbaGZbIw74ofQJNPxU27aQhNdKNNY4N0QienQ9zXSHD6h3qhbZEY9IDheZpmCOjymOsAUtknS/q8nbmWA==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ch19-20020a5d5d13000000b00337b47ae539sm13337744wrb.42.2024.01.31.04.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:00:07 -0800 (PST)
Date: Wed, 31 Jan 2024 13:00:04 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: karthiksundaravel <ksundara@redhat.com>, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, rjarry@redhat.com,
	aharivel@redhat.com, vchundur@redhat.com, cfontain@redhat.com
Subject: Re: [PATCH] ice: Add get/set hw address for VF representor ports
Message-ID: <Zbo2RJErBsD0Sc_z@nanopsycho>
References: <20240131080847.30614-1-ksundara@redhat.com>
 <ZbokUx7myZ1bVWLL@mev-dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbokUx7myZ1bVWLL@mev-dev>

Wed, Jan 31, 2024 at 11:43:44AM CET, michal.swiatkowski@linux.intel.com wrote:
>On Wed, Jan 31, 2024 at 01:38:47PM +0530, karthiksundaravel wrote:
>> Changing the mac address of the VF representor ports are not
>> available via devlink. Add the function handlers to set and get
>> the HW address for the VF representor ports.
>> 
>> Signed-off-by: karthiksundaravel <ksundara@redhat.com>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_devlink.c | 134 ++++++++++++++++++-
>>  1 file changed, 132 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>> index 80dc5445b50d..56d81836c469 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>> @@ -9,6 +9,8 @@
>
>As Jiri already wrote, you are not changing MAC of VF in your code. Try
>to look at ice_set_vf_mac in ice_sriov.c. In current implementation you
>nedd to set new MAC value for VF and reset it. You shouldn't use PF VSI.
>
>Pointer to VF you can get from representor struct (through parent VSI).

What if it is in a different host? Would you still be able to change the
mac?


>
>You shouldn't manage the rules during MAC changing, as in switchdev
>slow-path there shouldn't be VF MAC rules. It can be problematic as user
>already can have MAC + sth rule (which also needs to be change). I will
>leave it to user (most probably the MAC change happens before adding any
>rules).

Rules are on the representor, not the VF, correct? Seems unrelated to
me.


>
>In few days we will send patchset for subfunction support where the
>subfunction MAC chaning is implementing from devlink API. I will add you
>to the CC.
>
>Thanks for working on it, it is a gap in our solution.
>
>Thanks,
>Michal
>


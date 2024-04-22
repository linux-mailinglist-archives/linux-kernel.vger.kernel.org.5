Return-Path: <linux-kernel+bounces-153353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C838ACD05
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66D2282796
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A835F152DE8;
	Mon, 22 Apr 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZYbQ366"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708414A61A;
	Mon, 22 Apr 2024 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789606; cv=none; b=EmvCoigp3OdIr2r9yKhIRyaounqgYnsWiO8qMDjiw1qt8dyq3AWIb+ew+cv4J/gCdsrAnnbOXToVbQkIJswFCIDljNPbw13JTd4MNzVyKz/Tv8FwJnR25pnX7veeevaT/vpFkPjJa3lXGDlpgjwg5zzZI2eTD21RCYxjABqaf7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789606; c=relaxed/simple;
	bh=EDx6TY1wZzwdL7NzrbCkXEJtOWAtBySSVQbpTqRu25g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/wKDkWPf36EQwsONaaQ7CPQID3WCPDiVIkVxYOhgLJTe+ho0MQekHNo3PdEoVluMFL+BgnE4vdv7nWioFOKKB/JqR35gVaWkDqDTN5TgT8jMPGDgekz4wSkfOXLjOwYzKNDxtgCZnvlndoGIBgajvPpHfO0tTQIN1IDwFJOxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZYbQ366; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713789604; x=1745325604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EDx6TY1wZzwdL7NzrbCkXEJtOWAtBySSVQbpTqRu25g=;
  b=bZYbQ366sWX+FEXm1Im3hGsnq07s54Qv07NByGwXou1OogUuTjsDq/GD
   bz6hba7G+lA7D6KV/c4WrYY7B5wb6blyXqDHwJhY+scR23M2l13jzqLpz
   P8ux6KlYpmr3SDlbZgIMHOupXlOlORsyaDmyTlpKbjQjsWOpobijalYdJ
   5p5j7lu49qTDf0zkddm4T6sBgNDDl4JV5ovz65YjIvx39+bdDYF/pla+J
   1LRoWNLt+TTxaSbtqBk0S3Ca5Qcv9JOfzMLmN+5v1Izc3anaFjYcJ8ctB
   JsubJ2hsLUXFgCIT5MrvnLxonP8pomcU6iTh4V+grBciQcNKw8X9iD41Q
   g==;
X-CSE-ConnectionGUID: 2X6rKkCnTb2/tYTsLFx1gw==
X-CSE-MsgGUID: NR3cS+9aT7qhbapbzTZZ4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9543867"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9543867"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:40:03 -0700
X-CSE-ConnectionGUID: kMyo4nblQsasHWi2/ePd4w==
X-CSE-MsgGUID: C12mu43PR7Ow0/Wg2KPXMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28680298"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa003.jf.intel.com with SMTP; 22 Apr 2024 05:39:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Apr 2024 15:39:58 +0300
Date: Mon, 22 Apr 2024 15:39:58 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] usb: typec: ucsi: Delay alternate mode discovery
Message-ID: <ZiZantUKg8K5Nqk+@kuha.fi.intel.com>
References: <20240419211650.2657096-1-jthies@google.com>
 <20240419211650.2657096-4-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419211650.2657096-4-jthies@google.com>

On Fri, Apr 19, 2024 at 09:16:49PM +0000, Jameson Thies wrote:
> Delay the ucsi_check_altmodes task to be inline with surrounding partner
> tasks. This allows partner, cable and identity discovery to complete
> before alternate mode registration. With that order, alternate mode
> discovery can be used to indicate the ucsi driver has completed
> discovery.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index b8d56a443531f..cd4c3b7a5d989 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -963,7 +963,7 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
>  		con->rdo = con->status.request_data_obj;
>  		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_PD);
>  		ucsi_partner_task(con, ucsi_get_src_pdos, 30, 0);
> -		ucsi_partner_task(con, ucsi_check_altmodes, 30, 0);
> +		ucsi_partner_task(con, ucsi_check_altmodes, 30, HZ);
>  		ucsi_partner_task(con, ucsi_register_partner_pdos, 1, HZ);
>  		break;
>  	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
> @@ -1247,7 +1247,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  	}
>  
>  	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
> -		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
> +		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
>  
>  out_unlock:
>  	mutex_unlock(&con->lock);
> -- 
> 2.44.0.769.g3c40516874-goog

-- 
heikki


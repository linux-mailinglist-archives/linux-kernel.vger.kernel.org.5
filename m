Return-Path: <linux-kernel+bounces-58297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5530B84E42E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D021C20E84
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B17D3ED;
	Thu,  8 Feb 2024 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpUTJHmm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE97CF3B;
	Thu,  8 Feb 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406933; cv=none; b=HJ9lKbDye+VH+CKFcHh5psy+Ajg1oag8kPosmYOH+1oxL9mtxk+ZRhYdtkP12ILjSzNOfdvD/BGo9I2MFWR59WyM9dMeeh3zxXlzhZxyz76VBnZaYrBXlNdw7LGJtoQWW0aqJqjTOAtr028qDVvk1JWfa0atMr65o4+RrRmvjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406933; c=relaxed/simple;
	bh=Gq/MeCq8tAdioyMIzNGvwfo3UL2xJNXqTKNa0zXA520=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oR0Ay0Uf6GUbOmbPKXjpw8xIzd/t2BsrGgaXV88am6Z22sUj0v0GHJn3H542bmpZYumksypHOjewchUM7G5tqCgiZ6TlmiCU3k3jK+6F7hjpu1ujRw52WlLp867g7Z2PlbhRLQ5sWxXOT96p7wQLOZLsEl6Ozt2CY4dcxNJua5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpUTJHmm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707406932; x=1738942932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gq/MeCq8tAdioyMIzNGvwfo3UL2xJNXqTKNa0zXA520=;
  b=dpUTJHmmx+tUbSiGY3PZ+brOzgFB4qFXAT41Rq2edum36yCT/lWSJCbP
   1TL3Rb2EviiZZ3LvvYW7SmkQ2lfi+cK+3n46gxf/O/FlBX9shEAYWtt7s
   heskK0oTM/aczEy1lcG6RtP3u03mNkkuEeVmR125fUf6CSSYBq3huSKUp
   CdfIUXH+DFaCEN1k41lurlQdrWx56aOXUZCscUW8O6kE2Umng+kra8kc+
   EpAEMykH7u87Og+C77uavz4geBiG8eiDlMksmy01cXX3efy9HelexuIRS
   7iP8WgIbXlFtEHStzQ3uvdldCp0uDPUjNsZY91CIITT3zzH2sRN53WFsw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="23721935"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="23721935"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 07:42:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934162468"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934162468"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 07:42:08 -0800
Message-ID: <a026ecd8-6fba-017d-d673-0d0759a37ed8@linux.intel.com>
Date: Thu, 8 Feb 2024 17:43:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: =?UTF-8?Q?Re=3a_This_is_the_fourth_time_I=e2=80=99ve_tried_to_find_?=
 =?UTF-8?Q?what_led_to_the_regression_of_outgoing_network_speed_and_each_tim?=
 =?UTF-8?Q?e_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c75849406?=
 =?UTF-8?Q?c?=
Content-Language: en-US
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <Zb6D/5R8nNrxveAP@cae.in-ulm.de> <Zb/30qOGYAH4j6Mn@cae.in-ulm.de>
 <CABXGCsPu73D+JS9dpvzX78RktK2VOv_xT8vvuVaQ=B6zs2dMNQ@mail.gmail.com>
 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com>
 <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com>
 <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
 <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com>
 <CABXGCsN5_O3iKDOyYxtsGTGDA6fw4962CjzXLSnOK3rscELq+Q@mail.gmail.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <CABXGCsN5_O3iKDOyYxtsGTGDA6fw4962CjzXLSnOK3rscELq+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8.2.2024 12.32, Mikhail Gavrilov wrote:
> On Thu, Feb 8, 2024 at 2:23 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>>
>> My guess is that CPU0 spends more time with interrupts disabled than other CPUs.
>> Either because it's handling interrupts from some other hardware, or running
>> code that disables interrupts (for example kernel code inside spin_lock_irq),
>> and thus not able to handle network adapter interrupts at the same rate as CPU23
>>
> 
> Can this be fixed?

Not sure, I'm not that familiar with this area.
Maybe running irqbalance could help?

Thanks
Mathias


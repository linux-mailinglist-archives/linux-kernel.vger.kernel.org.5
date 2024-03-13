Return-Path: <linux-kernel+bounces-101665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4443887AA37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D091C21879
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E9A45BF3;
	Wed, 13 Mar 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZbkr+3f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F82D600
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342960; cv=none; b=hfAaMYertip5VmO1QaIdL3JhME5Y+9ALnKSK800nvsmbCLX/vjGeSeSOTD7QyBfg81hGoMCk/9pxgAA0C1p8zcx/0e0k7U5TwvRjDNvWQhECVbqBORQZxFKcnDqE998Svlvfm8jIc3WMCzSCr/ZwDAGs6xxRWUPWtuUYYh/BFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342960; c=relaxed/simple;
	bh=wo+8XUVZ6ioK9G4Sp1j0QYOyDvxZDEEvuVlcXX0TV+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9SWE4DNdnpWiM9HPn8NLSl4M8ykTqIgb4dEilsyUG+lSuvBXocGsHMWmWjSX6fY/8cv8ML9Q8ebEfIwNmzAMTVdGaGfalWD6df1v+z6NDWxLg6Mv/4ZGn/cOK8oIqWceL70w/ViG8flWYhsKggg4bMw+EgjYIqL/Rndvu5+PqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZbkr+3f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710342957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zitympJcMqQpZuvfBggEaIHiO0WpMlfnPdF8UjN+huc=;
	b=SZbkr+3f+/9smXXv6f7M33GxFFDVdGzgaRgNt/U2LA4mTGqudaKft5uN/JVDqt98JpaksR
	tc0tvRo20Qf+8gKWQkvwEHn2G6jOZT3I6hKYUmRArUil9GhfAwhxn/6PoukwXji0VzVKFf
	BE/REcxO/ABD7vl4Smyu5Pb4Kt6IsCE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-HkdNa89aMmqpz2KCcnIf3g-1; Wed,
 13 Mar 2024 11:15:54 -0400
X-MC-Unique: HkdNa89aMmqpz2KCcnIf3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FDD43C0C8A1;
	Wed, 13 Mar 2024 15:15:53 +0000 (UTC)
Received: from [10.45.224.236] (unknown [10.45.224.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C0D213C23;
	Wed, 13 Mar 2024 15:15:51 +0000 (UTC)
Message-ID: <3f934c7b-867c-4550-93ea-4f567807fa98@redhat.com>
Date: Wed, 13 Mar 2024 16:15:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: Enforce software interrupt during busy-poll
 exit
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, pawel.chmielewski@intel.com,
 aleksandr.loktionov@intel.com, Hugo Ferreira <hferreir@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240313125457.19475-1-ivecera@redhat.com>
 <CADEbmW3NQ7SQpccOqTD=p_czpBbOY=41kS7krwx2ZEDmFfcgrg@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CADEbmW3NQ7SQpccOqTD=p_czpBbOY=41kS7krwx2ZEDmFfcgrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1



On 13. 03. 24 14:47, Michal Schmidt wrote:
>> -/* a small macro to shorten up some long lines */
>> -#define INTREG I40E_PFINT_DYN_CTLN
>> +static inline u32 i40e_buildreg_swint(int type)
>> +{
>> +       u32 val;
>> +
>> +       /* 1. Enable the interrupt
>> +        * 2. Do not modify any ITR interval
>> +        * 3. Trigger a SW interrupt specified by type
>> +        */
>> +       val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
>> +             I40E_PFINT_DYN_CTLN_ITR_INDX_MASK | /* set noitr */
>> +             I40E_PFINT_DYN_CTLN_SWINT_TRIG_MASK |
>> +             I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_MASK |
>> +             FIELD_PREP(I40E_PFINT_DYN_CTLN_SW_ITR_INDX_MASK, type);
>> +
>> +       return val;
>> +}
> This function is called only from one place and with a constant
> argument. Does it  really need to be a function, as opposed to a
> constant? Or are you going to add more callers soon?

This can be reused also from i40e_force_wb() but I didn't want to make 
such refactors in this fix. Lets do it later in -next.

Ivan



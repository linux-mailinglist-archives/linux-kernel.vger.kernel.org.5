Return-Path: <linux-kernel+bounces-109587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87F6881B25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AEA1C2215C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196BD6FCA;
	Thu, 21 Mar 2024 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTJPgzbT"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB76FBF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987262; cv=none; b=XOahO8DRQN8mI/U0nxnfNAdgf5z1of91+yOCuA2LwTaz+KdQvF9eoRKWMuhK5cA14n0JYAC6qPrq3s7zST20er/U+KiyYhX3CNWSFBLEegOAjgZksp4QrtWW1bS1PH63836rjZarATEgt43Q9cfXWiAwPepJuTZnvos7T9h4oD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987262; c=relaxed/simple;
	bh=YnNPWvuEyLBYDEcjFH8hQxrrb4E8nb6FVTMwWf4qx3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6v+cYtqdFdxypkzwyD36nAHKPHI1ja/voH0JlS2nEb1YKHGlOgPQd/XqTEpAfjq27o+u0JX+NpLbH6yDUrnHMaqZHHqym7jK4SIuFRn2+Mx2IFAaKQg9fkzfGKaOj9iy81d082TfSr9TtBDsQWpJbIw/EWEX6kGnoB+JC784UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTJPgzbT; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbbc6e51d0so332459b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710987259; x=1711592059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZZ0eBF1nVodLuO+Mf6tnyhoW2fNmSS0bAvLpCiGBQs=;
        b=gTJPgzbTLlircu+XeIliL3MGJCg6KUh/wbx3Hx8V63qzZv8BsXaLhizDpl6TMFINF8
         yYH76EuYpV2A6fh3mND9gyJRf1YCCTWXhXVPs8gc95RlFPlIGDd08eM3KaE9Ifyv9/7D
         DMIZ/avva2LaGuP0kueZJxqCzWtsqizMSUqPaMWsSEb3XtKqIrmswJ0AYPcupYDoS/tn
         rwEl4JE25mihGDgHuw1ea7mJ/3H81+Dp2PNU8Rgch0L9sL42+43wl7XIRcPiAFZkgmA5
         bzTN71TpxsdIqI0i4/UbBaVYkxbALjgwKF4gGRM79yYKNrRnPtgKq418fKgFge288qG1
         QD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710987259; x=1711592059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZZ0eBF1nVodLuO+Mf6tnyhoW2fNmSS0bAvLpCiGBQs=;
        b=U9wU3CM5MsZ8v2ilQ3ybHQK82R6JTh0NinI/JFDEH0Hsx+jL130ajSpqxmlbjmqqxb
         7Pl6gFU70r7FwxXpypqtbc+rPQ4OHccD+o3LwWsMn7O+Fa1zY0GOI44vaXfs9P4T8Scw
         705EMT0H8cHXXhz76QRIZ2pBywV3xITrMI3P3tYSxtJ45r1ScBkRSom/mWliTZGdwevI
         B5ezwUDTNIAk7sORg2D7l7Y86hW9C4lzK23Q4UwYEmE51a3tiHduo9hUR0pqLzH8AAmQ
         xHzU/womZ6lW1J/AnljPBVq2xW2En87IIQlKsJSHa60UR8ObzDAjYwjdungm3N+2MZ5r
         8qBw==
X-Forwarded-Encrypted: i=1; AJvYcCXYAm4e+fhpWcNs1FfSgp7tVJToGcbgsg/ZP0t4lhTog0CnBadVB7Bd67mcV2PCVDhS6g0DUsT4DL6SiHA15AlJhkvAYkKHuG3HYln1
X-Gm-Message-State: AOJu0Yz5jsqqaWnQXjkXozwf1JLnGr9wV3bx0xQOyfHk0JnSIiNk7JRk
	Rb2ExlTtr8QjLerk1XK13GdiPgf9d4WyYGjsQRSvCRaFlWue/MwEv3irJ9IM
X-Google-Smtp-Source: AGHT+IGX9Hf4aM8VLWNa/s52FKlPfTb0CfuKELwn7sB6KrWJ9G2rS7tuQj9ARTH3dU1o8nyF9AlDNw==
X-Received: by 2002:a05:6a21:9102:b0:1a3:1246:c43e with SMTP id tn2-20020a056a21910200b001a31246c43emr873720pzb.28.1710986882260;
        Wed, 20 Mar 2024 19:08:02 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a178200b0029bacd0f271sm2564887pja.31.2024.03.20.19.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 19:08:01 -0700 (PDT)
Message-ID: <1499f4f3-db06-4330-b2d6-fde57a3fbe04@gmail.com>
Date: Thu, 21 Mar 2024 10:07:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] mm/ksm: Convert get_ksm_page to return a folio
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, alexs@kernel.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>,
 Chris Wright <chrisw@sous-sol.org>, kasong@tencent.com,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240320074049.4130552-1-alexs@kernel.org>
 <20240320074049.4130552-2-alexs@kernel.org>
 <ZfrcihNz74lDDg1J@casper.infradead.org>
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <ZfrcihNz74lDDg1J@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/20/24 8:54 PM, Matthew Wilcox wrote:
> On Wed, Mar 20, 2024 at 03:40:37PM +0800, alexs@kernel.org wrote:
>> -static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
>> +static void *get_ksm_page(struct ksm_stable_node *stable_node,
>>  				 enum get_ksm_page_flags flags)
> 
> I am really not a fan of returning void * instead of a page or a
> folio.  Particularly since you rename this function at the end anyway!
> 
> You should do it like this:
> 
> In this patch, convert get_ksm_page() to get_ksm_folio() and add:
> 
> static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
> 		enum get_ksm_page_flags flags)
> {
> 	struct folio *folio = get_ksm_folio(node, flags);
> 	return &folio->page;
> }
> 
> Then convert each call-site to get_ksm_folio(), and finally delete
> get_ksm_page().  That way you're always converting each caller to
> the exact code you want it to look like, and your reiewrs don't have to
> keep three patches in their head at once as they review each place.
> 
> Also, I think this should be ksm_get_folio(), not get_ksm_folio().
> Seems to fit better.
> 
>> @@ -949,32 +949,32 @@ static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
>>  		 * in the ref_freeze section of __remove_mapping(); but Anon
>>  		 * page->mapping reset to NULL later, in free_pages_prepare().
> 
> Could you fix page->mapping to folio->mapping in the comment?
> 

Thanks for comment! I will take your suggestion and resend soon. 

Best regards!


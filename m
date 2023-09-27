Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3287B0375
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjI0MD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjI0MDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993ACBE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695816190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OIJdWPFNkLfDudtONt3WjWlis6fmp6gJVF1FOUUG9fU=;
        b=dJ/V5CGeFo375LDmCLRFuQBwzQlU96E1RGWtDKZIEGxn+6Pili4+/ZBknZkUVYnajA8bWi
        ulKq4jeuGzNmz59yQO27UkMSt9/knazeJuM4sy0Svj4fUWqGxP3rVxd5Fr+oO3HZXANuQK
        44VpopSZGQ5u7428AxThkH1Nn0GbYZ0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-07gToLrZP8-QlgcisbXZ_w-1; Wed, 27 Sep 2023 08:03:09 -0400
X-MC-Unique: 07gToLrZP8-QlgcisbXZ_w-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7742bab9c0cso1278454385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695816189; x=1696420989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIJdWPFNkLfDudtONt3WjWlis6fmp6gJVF1FOUUG9fU=;
        b=MhjgaQuweI0zkLqLRFYNDbvgKnbNuVEpgTBglHZIX3BJCitniXzsforACNOp7bUNbb
         sX2+LMoVU+X8gwRI8rBqa+qhrkpd7Zgw1sStbQg3NIqB+GhODg06tF72CS3hO6tc8tW+
         YmIuMr7YwqB0cP9k8R6SQ2XzyQ+MipI+ANaMpb9yaT9qxVE6HEIoLmUq72RFZ8TAW1ik
         EenJ29iVWEH6qfhj9YR6xXJyq0OY5RZAS2v3k2LPDM2XhTgW8lTNqjgWNX5nIJ+mIcEC
         b2IOFQq6ph2jSFuEDYNQdEMAjVUUBLElfEGtiQuX63QBF2fpjonowB7eT4xD7F/oiCP7
         ohfw==
X-Gm-Message-State: AOJu0Yx6+wWC4k+3+0XiG43Ce3q66IiA94qHTLe6Dh403yxUTRAP23OX
        4XKX3LaQWFZayGRwnWx3uAKnj8xHMIyTcYEG8fqX5q1YBvVX3sdEzvQaEf/8a5hQ0kxC5E7JbrR
        pWdzyrgp/2YER9pWtyiqBHiSb
X-Received: by 2002:a05:620a:3885:b0:774:108a:b537 with SMTP id qp5-20020a05620a388500b00774108ab537mr1323438qkn.42.1695816188939;
        Wed, 27 Sep 2023 05:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/e4xgrXENJoifhRKXLsQ1PlmJmOxOGeD34II+VIHXNNhkFbt7ctmSpSSOxYIwcBi5qLWAQQ==
X-Received: by 2002:a05:620a:3885:b0:774:108a:b537 with SMTP id qp5-20020a05620a388500b00774108ab537mr1323395qkn.42.1695816188475;
        Wed, 27 Sep 2023 05:03:08 -0700 (PDT)
Received: from [10.16.200.42] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w15-20020ae9e50f000000b0077423f849c3sm3607412qkf.24.2023.09.27.05.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 05:03:07 -0700 (PDT)
Message-ID: <2010c7a4-8754-2563-cd55-35bdd854d04e@redhat.com>
Date:   Wed, 27 Sep 2023 08:03:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net: appletalk: remove cops support
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        jschlst@samba.org
References: <20230927090029.44704-2-gregkh@linuxfoundation.org>
 <ZRP1R65q43PZj7pc@infradead.org>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <ZRP1R65q43PZj7pc@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/23 05:26, Christoph Hellwig wrote:
> On Wed, Sep 27, 2023 at 11:00:30AM +0200, Greg Kroah-Hartman wrote:
>> The COPS Appletalk support is very old, never said to actually work
>> properly, and the firmware code for the devices are under a very suspect
>> license.  Remove it all to clear up the license issue, if it is still
>> needed and actually used by anyone, we can add it back later once the
>> license is cleared up.
> 
> Looks good:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> 

Ditto.

Acked-by: Prarit Bhargava <prarit@redhat.com>

P.


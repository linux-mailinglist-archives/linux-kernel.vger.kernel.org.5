Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB87D0CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376799AbjJTKHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376715AbjJTKHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:07:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5DCD64;
        Fri, 20 Oct 2023 03:07:14 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso5305535e9.3;
        Fri, 20 Oct 2023 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697796433; x=1698401233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eg/csZTe11WF84HY2bC30HCtKA95bWgVvxI9p/8afRY=;
        b=W/1H7+mxcgaW2CIZYzlMcgQmGAkNadgMutA1aQstRAx9seq239n1cCjK/Hb3GePFU7
         oTyN5GT+MGBb7uwWj39MSJTqvbVL+rM+zFhdKRTn4KXT3M4uS39UxDxbuQKTCibZEZ79
         kDVkcFl3q08PLSlfw9O9SV0KVxz83GGdKedAFdvdA0N2gaPbuU0qDCiSUK1IXeRQUBuJ
         yClwWAe5ZQJCuN9DuDm19GaHekHy7k+sriVO270bN6Meo6kSbMTTsUp6BKLEqOJcoZ4o
         rVSQ9BJZ3ZWcbzB6EVwFuAZGQb7sqKloI7CQH9MBWLZtBvY96xKCIOnS1pKVSvdEEUyN
         i+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697796433; x=1698401233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg/csZTe11WF84HY2bC30HCtKA95bWgVvxI9p/8afRY=;
        b=MedMJRwlHgNMeTbIGyJX7TKd+FKnmNJVzeuNcNncpKGuT1niv7qr2Qv91CT0to9Onc
         1gBe64QnjDfMbKmSqsDeoUL/L9hObYQ62bE1l6uJ5EKXgOKGNqOQpty8tOJbYUgONnp4
         DVqAUNmM45moPum67EL9huBX2t92y38EuQe7R0d/bYQEoKrquRQ+6JwBE9bfLwt6eZmJ
         J2jUL0zHsFVnofyfOFhGFuwzAQKaFydiDKJAZiGvLmS5jKbZjijM5TFnKObetybCGeBY
         ub3KjOkPTYDxxDQJDZCfElFhFUujs2IWbfBPLE88joK/8VbmH46zSnPfsHK2WNlh5lrU
         Wn6g==
X-Gm-Message-State: AOJu0Ywv7/SaSRthovZesJ1yGF8rLM98NW4+/1QyC5FTBRZxYFiPDN76
        o89UVSym26DFQUgeY5dN/jY=
X-Google-Smtp-Source: AGHT+IEqZwxXRL66lw1+cuj95TIKompxhoWp5WEAhk2qvUt3UtBRe+YVmcGEZrYV3uvDzSEbs5b0Rg==
X-Received: by 2002:a05:600c:510d:b0:406:53f1:d629 with SMTP id o13-20020a05600c510d00b0040653f1d629mr1084077wms.5.1697796432432;
        Fri, 20 Oct 2023 03:07:12 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id w15-20020a5d608f000000b0032dbf32bd56sm1343204wrt.37.2023.10.20.03.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:07:12 -0700 (PDT)
Date:   Fri, 20 Oct 2023 13:07:09 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: add an error code check in
 mv88e6352_tai_event_work
Message-ID: <20231020100709.yy2ovjm3q2hphek6@skbuf>
References: <20231020090003.200092-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020090003.200092-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:00:04PM +0800, Su Hui wrote:
> mv88e6xxx_tai_write() can return error code (-EOPNOTSUPP ...) if failed.
> So check the value of 'ret' after calling mv88e6xxx_tai_write().
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---

mv88e6xxx_avb_ops :: tai_read() and tai_write() come in pairs for the
existing implementations. So, a missing tai_write() method also implies
a missing tai_read() and would have been caught by the previous call to
mv88e6xxx_tai_read() in this function.

But, ok.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

This is a patch for net-next, as it doesn't fix any user-visible issue
and is just an improvement. For future changes, please note your
expectation regarding the target tree yourself, by formatting the patch
as "[PATCH net-next]".

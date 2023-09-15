Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7679A7A22EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjIOPtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbjIOPs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:48:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDDC2710;
        Fri, 15 Sep 2023 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=leftU7vnx6ubtSCIPio+hyF+23cQ6uL5tDPuDZIs4dk=; b=YYqjIA6Phg4gWr7cpr90C7AQMG
        JPBckC5Gp1gat/6r+oY6tjpgDW2+MFCpZSMEDW3nt665gO51B+Du/Mg+YnEcWoAb7R3hkyhcBF0cT
        PiGlO3s6ZnHcXbXKr9QsStIrRq0KhTZYMPGQ7jfzMdzS2VGcoau6RYdsgxnbVP072afdAkyhPatLG
        T7R4OmlL1OWfWdfFPXGK0eifZ+B1dEwoWLHTAJiq6rYRw+hlrr5G9jZkOw2q3TFKN0+WiYKPfUx5q
        n1WOC1qIBz9/wzIHSnpi6BegyzrRyOFcNMFftrs34uJ4iHR5x9pAKQsQnbWWnlbkq1dVk4OtR1B/P
        BhPoA3uQ==;
Received: from [2601:1c2:980:9ec0:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qhB3C-00B13L-1W;
        Fri, 15 Sep 2023 15:48:10 +0000
Message-ID: <6b507126-c4e6-40f2-9574-fe1abb0463ee@infradead.org>
Date:   Fri, 15 Sep 2023 08:48:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional
 dependencies
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230913113801.1901152-1-arnd@kernel.org>
 <874jjwx44g.fsf@intel.com>
 <b2723c56-e2b0-4871-afbc-73cf6335ddca@app.fastmail.com>
 <CAK7LNAR9Jt0FQNRidcxY-OxMh7N238Xs33Tyj+dpTZ5wGow0wQ@mail.gmail.com>
 <763b1599-06b7-490e-9cbf-eb07f1deedb3@app.fastmail.com>
 <87sf7fvqiz.fsf@intel.com>
 <bc27450a-74cd-49f5-bc88-f102b0edb345@app.fastmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <bc27450a-74cd-49f5-bc88-f102b0edb345@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 00:44, Arnd Bergmann wrote:
> On Fri, Sep 15, 2023, at 09:34, Jani Nikula wrote:
>>
>> IS_REACHABLE() considered harmful.
> 

+1 absolutely.

> Absolutely agreed, and I'm sorry I introduced it in the
> first place in commit 9b174527e7b75 ("[media] Add and use
> IS_REACHABLE macro").
> 
> At the time, it was only used by drivers/media, which used
> to have a lot of open-coded instances of it and a lot of
> wrong checks.
> 
> Having a formal syntax for it was an improvement for
> drivers/media since it was more broken before, but it's
> usually a mistake to use it when there is another solution,
> and we probably should have tried harder to fix the
> dependencies in drivers/media at the time.
> 
>       Arnd

-- 
~Randy

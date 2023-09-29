Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303CF7B3602
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjI2OtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjI2OtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:49:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA6E1B1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:49:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40537481094so146204805e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695998950; x=1696603750; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zXIX6Tilo9Gjx9RWl2BtStnv1ul2R/mNiwRxznI4chY=;
        b=qHl7YQGQtZIDHiDEB7CrGWg9aUUmq0VB06fKfhJevUrEmBuqq9yvpL1n1mSjr/FnI+
         /AQtViXnW2aWibpk5YeiGJdWA+ddLz8UMIRV3/L4Cs1CSrvD5GbPEaybjCyRUiCqlQAl
         w9zINtu0gFFtPhM850tnM94ux3fIJyc4qVsyNOILceYHs/aHwjvX1mQZv30kICHQWQu4
         mAKr8m36eKfT1eoTWR6Yz+DLk3z26gfiWKrmQpaWZ/bVojzJ6ePzPomNOb9LOhPl7OwQ
         BdyUz5mn5sSKM6Z71OCcRxt/bmLFKjjfJKYJX3BbLK6eUhS8zXU9UqfkFbMdrTZcG5Zf
         dMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695998950; x=1696603750;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXIX6Tilo9Gjx9RWl2BtStnv1ul2R/mNiwRxznI4chY=;
        b=rhQxlK1Ibmtem1lqFB7fzBZeBySW42VXfNPaADybVstaxkqomm94YEhgwaoVJjxZMF
         n8Fr0lsKN7AZGsPnkuTfLiOL6aSel2E1mUH9fazKyhRmIcb+Jd72WejQIBh3ZdMM9P6+
         zORnIcxvq0h4hZ2YO0wo3PU2K46pboo/ctXQc+EKGqcas7XWclle9c5/0Kia7WuEtQSm
         sssQEWDdDWr5+rSMH93RubhbNO2dCCKwcxpx2P0dvkovE3B3aIOSZF5sEfyhQSNm4IoB
         5qSDw8K3t44jn+sJg7hSCGht/nTHUu8mZIPDyLSYukR45SB3F/sqU/6rtLG+VXqhl4mv
         Cp1g==
X-Gm-Message-State: AOJu0YwLN6bmSleu5DkUu4x9/1rd3wQaGq92XW1hqrZm0feSm6hHpvb1
        E+QWR3YzSwa4Ivbz0DQWwGS9jQ==
X-Google-Smtp-Source: AGHT+IEqbI2tfElGGztUmr9zivPQIXjUP4pmmtJGpHrCCxxjX9+d+aNuJYAjJH5TH7IX37Xx1HnEKA==
X-Received: by 2002:adf:ee10:0:b0:319:71be:9248 with SMTP id y16-20020adfee10000000b0031971be9248mr4128645wrn.19.1695998950027;
        Fri, 29 Sep 2023 07:49:10 -0700 (PDT)
Received: from x1 ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id z7-20020adfec87000000b0032179c4a46dsm4080161wrn.100.2023.09.29.07.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:49:09 -0700 (PDT)
Date:   Fri, 29 Sep 2023 16:49:07 +0200
From:   Drew Fustini <dfustini@baylibre.com>
To:     Peter Newman <peternewman@google.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tony Luck <tony.luck@intel.com>, babu.moger@amd.com,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jon Masters <jonmasters@google.com>,
        Stephane Eranian <eranian@google.com>, palmer@rivosinc.com,
        atishp@atishpatra.org, ved@rivosinc.com,
        Vasudevan Srinivasan <vasu@rivosinc.com>,
        darren@os.amperecomputing.com
Subject: Re: resctrl2 - status
Message-ID: <ZRbj49fDIAt/gX13@x1>
References: <ZOlRNTq3lE7VNHjU@agluck-desk3>
 <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
 <ZPjDHN0nvHz9kWFn@agluck-desk3>
 <18f3a209-8dbf-4837-6bcb-a71a1ee1abb3@amd.com>
 <SJ1PR11MB6083849D1AEF44806C4D669AFCEDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <09e2894e-eb2b-12a0-c4a2-5000b27bbded@amd.com>
 <ZPuqsupe+BevodqO@agluck-desk3>
 <ZQSY5P8R5Q+OuvXB@x1>
 <20230918114420.000058c3@Huawei.com>
 <CALPaoCiDrbfAYW1sHgozVUew2wdvuGgkATbO62Dj0BEiQf5cZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCiDrbfAYW1sHgozVUew2wdvuGgkATbO62Dj0BEiQf5cZg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:47:22AM +0200, Peter Newman wrote:
> On Mon, Sep 18, 2023 at 12:44 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > Drew Fustini <dfustini@baylibre.com> wrote:
> > >
> > > This reminds me that Linux Plumbers Conference [1] is in November and
> > > I think resctrl2 could be a good topic. The CFP is still open for Birds
> > > of a Feather (BoF) proposals [2]. These are free-form get-togethers for
> > > people wishing to discuss a particular topic, and I have had success
> > > hosting them in the past for topics like pinctrl and gpio.
> > >
> > > Anyone planning to attend Plumbers?
> > >
> > > I'll be going in person but the virtual option works really well in my
> > > experience. I had developers and maintainers attending virtually
> > > participate in my BoF sessions and I felt it was very productive.
> >
> > FWIW I'm keen and should be there in person.  However, I'm not on the must
> > be available list for this one ;)   Agree that hybrid worked fine for BoF last
> > year.
> >
> > Jonathan
> 
> I got us a BoF session to talk about resctrl and porting it to new
> architectures:
> 
> https://lpc.events/event/17/contributions/1567/
> 
> To anyone planning to attend, while the schedule is still easy to
> adjust, please let me know if the proposed time (Nov 15, 4:30-5:15pm)
> doesn't work.
> 
> Also I got one registration code for scheduling this. Let me know if
> you want it.

Great, thanks for setting up a session for resctrl. The only thing I
need to attend is the RISC-V MC. Hopefully it will not be during that
time. I've cc'd Atish and Palmer in case they know. They may also be
interested in resctrl, too.

thanks,
drew

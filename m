Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01D7A4DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjIRQE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjIRQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B84CF0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695052871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOhdBYOOnOw2Xv4QV/a0Y13rP1z4QA5P773/OFzDxDo=;
        b=fLmPYhb7xRhUF7DEuh4nTTY5XSNinXTL3nPQeX0/53JU0D1XQzYtwHH/B/ZZoj4Wrmstuv
        ESIN9Ls3/Pxn/HGi7kiQIleN+rQWeS1EepZnMTN8Lo5R2cSDSx5Cq+PEjLDEyla+pHjvyN
        IgLd7o/yzmpJmqvZY7LJrHMh6EhQAbo=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-bneK1SKjOUOWUsz4mSW1Ug-1; Mon, 18 Sep 2023 11:54:28 -0400
X-MC-Unique: bneK1SKjOUOWUsz4mSW1Ug-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-59c07ca1b44so45869417b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052468; x=1695657268;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOhdBYOOnOw2Xv4QV/a0Y13rP1z4QA5P773/OFzDxDo=;
        b=mO46NuZXrDqWkUCmLCERlnHt61AP2yY3Im4EgtWmuAMDFLPmiKumdBIn7ifx6j8O3T
         ZbdmLLFastwptyH2FNwRj/YtrS0l4UG0fuwnQcjAX1iwAf0+64QYzfDU07xjRITRC3lo
         SdZo0kiOYXDAg8RenivkbHSxDY8u/v9Ug4ZQkwB9OlLNhGCK636kIl67ELILN693rcJz
         lgXZfFz3QinS/WTMjjKSKy8T4chdhEE3oRGxSZdgJotRSeEncsphDZyKGxuCUF5ksEHu
         xcqrmHwepOnYlt0oJnAHacJbDbSBJ0W9ZQI8mWvUD5rfXvH64ZcaAPZW12kkGtFAWR5x
         ZJhg==
X-Gm-Message-State: AOJu0YxWVKu+rxP0raRJUQHXP2JFYc3YYt8enl7iLQuhpJJrhz6wO14U
        J3OTv/jK51ay1oOJMzH7fYZjffGkjiRXBBEUce8vpEgfOg64p1I8in2Y2G5otX5tws+TT8v0W0o
        TF2s78YfQNnEuKcFywB+REzlU
X-Received: by 2002:a0d:d892:0:b0:58f:ae13:462b with SMTP id a140-20020a0dd892000000b0058fae13462bmr9906408ywe.4.1695052468201;
        Mon, 18 Sep 2023 08:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ+PPa37KkghWX0FxlMbPyu/VGLHVykUnMpS9N8b28iqb6GVc4LQaBkI7nwKXvPf5Ws77YcA==
X-Received: by 2002:a0d:d892:0:b0:58f:ae13:462b with SMTP id a140-20020a0dd892000000b0058fae13462bmr9906390ywe.4.1695052467962;
        Mon, 18 Sep 2023 08:54:27 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id v26-20020a81b71a000000b0059c0629d59csm2339594ywh.115.2023.09.18.08.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:54:27 -0700 (PDT)
Date:   Mon, 18 Sep 2023 11:54:25 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Nikunj Kela <quic_nkela@quicinc.com>, cristian.marussi@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Add qcom hvc/shmem transport support
Message-ID: <ZQhysWhFtR68iVMa@brian-x1>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <0efe305e-031b-bdf5-0268-ca1c6d562653@quicinc.com>
 <20230918151552.n3jvw2qqi5tmyfbb@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918151552.n3jvw2qqi5tmyfbb@bogus>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 04:15:52PM +0100, Sudeep Holla wrote:
> On Mon, Sep 18, 2023 at 08:01:26AM -0700, Nikunj Kela wrote:
> > Gentle Ping!
> > 
> 
> I will take a look at this later this week. That said, I am unable be
> gauge the urgency based on you ping here. You have shown the same urgency
> last time for a feature that I queued promptly just to know that it was
> abandon within couple of days. So I don't want to rush here simply based
> on the number of pings here. I need to understand that it is really that
> important. For now, I am thinking of skipping even v6.7 just to allow
> some time for Qcom to make up its mind and be absolutely sure this is what
> they *really* want this time.

Hi Sudeep,

Red Hat is interested in this patch set. Qualcomm is moving one of their
automotive platforms over to use SCMI and this will appear in that
product.

Brian


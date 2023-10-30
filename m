Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3B37DBC23
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjJ3Oyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJ3Oyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF7DC6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698677635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c2oYUOapUpDMkZzVo31vssGZsL+4QeQUhvW4D3+MIuE=;
        b=BhlD8sLmv7e3LpjyPHjgzIRLVDSWPEyJyeBlIqBMGDrmOeDD/rep5lh9w4SyDswf9HbtWK
        +vF9OTgocyOTrA0VeQf336J0ekmMRP4XA8+tqQK8IybRGeaJqbot/2m8p1/fv8OXg7HTqN
        JDMu4inYZGmnscsF9tZd4VSiatGJTzs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-l2n1MkZmM8eO0_4eGEDQbg-1; Mon, 30 Oct 2023 10:53:54 -0400
X-MC-Unique: l2n1MkZmM8eO0_4eGEDQbg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b2e0f24de0so6744734b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698677633; x=1699282433;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2oYUOapUpDMkZzVo31vssGZsL+4QeQUhvW4D3+MIuE=;
        b=DkTPT1oadyQ9iBO2tOJuFIbryKrGLBt/8afTkH4zrszFQ1ZzXd87eg0W/BoHiXRX78
         Y1hx4OCTor20wVGUNo21Pvx3OtEz5HsQdBnFuob5xS/ZWb8gJwaFwScD4j/KV3dlZHWX
         Y1BHa3AbWI7PhLhjqm/taPHoGg9iTDl4KXdTnw9PdUSZpXeUcz2PxYhNPKV8y3YmLifN
         o56deda08Y501rUtWUxJmDw/hn9EhQJhaHdv3yA51TC1YrBkW0qDPq5qIkU8GMvXc2ta
         +GZtblTclJT41b8QSL5dajhFHzdg9nbZT0JNFlio9Fd6z9uamfW2vkYCcPzDFK9Fx+zm
         e3xg==
X-Gm-Message-State: AOJu0YwCAkmNESx6M8nFW/rS5zdaYLfIERDRvfqChMyq2ThR7O3+ZJe3
        hEACyOFU0Xc5mHvqr5njThi6WwJqLzr3Z7Yhm4lvU3NspA/KWvA4GRJG/EusJ9fH6vXTrljK2/Y
        uWbr3O+cToxGNQyhHYSJ+lcNf
X-Received: by 2002:a05:6808:1302:b0:3a8:436f:3fff with SMTP id y2-20020a056808130200b003a8436f3fffmr13588636oiv.26.1698677633607;
        Mon, 30 Oct 2023 07:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3aVQA2RHuWFbArUkHNt8LDd14jicxffwRB9S6dWBo7lMP0QDrwTGdSm2NNwUIPbcjguOwvA==
X-Received: by 2002:a05:6808:1302:b0:3a8:436f:3fff with SMTP id y2-20020a056808130200b003a8436f3fffmr13588615oiv.26.1698677633376;
        Mon, 30 Oct 2023 07:53:53 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id m19-20020a05620a291300b007659935ce64sm3374135qkp.71.2023.10.30.07.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:53:52 -0700 (PDT)
Date:   Mon, 30 Oct 2023 10:53:50 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Add option to prevent disabling unused
 regulators
Message-ID: <ZT/DfnWWYkYPzkWB@brian-x1>
References: <20231028102423.179400-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028102423.179400-1-javierm@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 12:24:03PM +0200, Javier Martinez Canillas wrote:
> This may be useful for debugging and develompent purposes, when there are
> drivers that depend on regulators to be enabled but do not request them.
> 
> It is inspired from the clk_ignore_unused and pd_ignore_unused parameters,
> that are used to keep firmware-enabled clocks and power domains on even if
> these are not used by drivers.
> 
> The parameter is not expected to be used in normal cases and should not be
> needed on a platform with proper driver support.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for posting this! I've had a need for this. With Randy's feedback
addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>


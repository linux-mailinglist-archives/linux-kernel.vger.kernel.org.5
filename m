Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F79C7FB2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbjK1Hhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjK1Hhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:37:41 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945F31A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:37:46 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54bb260100eso210232a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701157065; x=1701761865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6gVvfRNPtJ9hR1Q42xqDgJWHxAsSJew352v7XMd5+I=;
        b=Q6IhPwX/rwSFky2IvnsJsL0f6ZRCJRdpv5wcrgEfcPvJFEfPUQN5Uho5lTDpSROg49
         +tyhtaU73urGpb5pz6gMMfYvKjUIBefLxta4LNTzDrEP4wOVJsmrWaez9dCxG4Idz3DZ
         vgDIStelzenXVGgNNVhYQhPxGBLTH9dOZxLIIM50QOL4NquUq11ZCK5048n2E+fBGmCL
         JyiDuadxudV6ryX08SeznPNEVknJfardCfQrGGIydY+S+t7muCZVeT/8PtUfKRmtC9Py
         KZgaGe+LL6UxLKxpLoVMT5OnXse32uhVGio2zATqMe35RqdOxPLyRPt5RtPs3VV1OlVT
         9FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701157065; x=1701761865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6gVvfRNPtJ9hR1Q42xqDgJWHxAsSJew352v7XMd5+I=;
        b=f/uo3GXLvE6O8XsswUwi48NkUFUYKPnDgmtINyGyFnVbrnYvA620QdJamVCIKwnY98
         PDWw+yTBnZnVz8J+5MuDOICdfbwAX1L3bDOWFExhdh3elDAZyzzFRULGrW2W6Gk5Zygi
         UhWQb7SphwofdZMGgIpASEWjKuTr7U2ZAHeXGB0jEw9TT/NEpYf1EDXZNtpOca2giwlm
         2m9noy7Ha5FjaO7tBvWmJ+sv5Yer8HaiYjALbb+0If8eQ3Dwbb123Bs+jrbz8lzN+UZj
         Loujz8LriQo7TyHa0L7fplrdOeg8AKp0tMtg1imb9aVxinIHZ0+WH9utLKCZtMhhoo7A
         oxUg==
X-Gm-Message-State: AOJu0YwZdO0/cUfu8AG6lEHQKH4WkVJvA2KEQKzdG3ZtphEfuPgeUUwI
        rBLq3zWf7nKjP2CAj0uHGYVFxQ==
X-Google-Smtp-Source: AGHT+IHAXJUbRXBLD3Z9+JAA4mWVgQhBtMGH+eJvQK3wdq7h5OaR9WMkkAhzTxCbBp5v+qc3JaetcA==
X-Received: by 2002:a05:6402:944:b0:54b:984b:6b53 with SMTP id h4-20020a056402094400b0054b984b6b53mr1598682edz.17.1701157064908;
        Mon, 27 Nov 2023 23:37:44 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h14-20020aa7c94e000000b00548a57d4f7bsm6072332edt.36.2023.11.27.23.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:37:44 -0800 (PST)
Date:   Tue, 28 Nov 2023 08:37:43 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Bahadur, Sachin" <sachin.bahadur@intel.com>
Cc:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net v4] ice: Block PF reinit if attached to bond
Message-ID: <ZWWYx18w2BnLyAZL@nanopsycho>
References: <20231127060512.1283336-1-sachin.bahadur@intel.com>
 <ZWRkN12fhENyN4PY@nanopsycho>
 <BY5PR11MB42574D2A64F2C4E42400213A96BDA@BY5PR11MB4257.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB42574D2A64F2C4E42400213A96BDA@BY5PR11MB4257.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Nov 27, 2023 at 05:23:55PM CET, sachin.bahadur@intel.com wrote:
> 
>> Nack. Remove the netdev during re-init, that would solve your issue.
>> Looks like some checks are needed to be added in devlink code to make sure
>> drivers behave properly. I'm on in.
>
>Sure. This fix should apply to all drivers. Adding it in devlink makes more
>sense. I am not a devlink expert, so I hope you or someone else can
>help with it.

No, you misunderstood. I'll just add a check-warn in devlink for case
when port exists during reload. You need to fix it in your driver.

>
>> 
>> 
>> >+			return -EBUSY;
>> >+		}
>> > 		ice_unload(pf);
>> > 		return 0;
>> > 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>> >--
>> >2.25.1
>> >
>> >

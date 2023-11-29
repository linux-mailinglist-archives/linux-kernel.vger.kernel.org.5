Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705967FD9D8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbjK2Olq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbjK2Olg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:41:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED97919AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:41:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54b7ef7f4d5so4264818a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701268893; x=1701873693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yyYsrVXR9VfHQeLrjs7Rji7raTyh+wNRCcIFYzXejwI=;
        b=i0yLVIMqpNVNX8hyANt/h0YDDvl9K0JE2SkT4Er90fHaikUj6P8pG6vtu5qr3jZVOr
         BL4yWpHW7g2kjSWmtR0F0Ex6suH0Lx0aEmUUBBFxgQV/aj2nM6gLjJR7eZs4wuHrQLyA
         S4VsZuev7LLUXSnr54yPTnYn+CFwc4oQbu0Yf3X5FTjqfjM6gys3wCJNAllaugErfTQj
         8RROMH7ABa+p2bztqnJ882iTs/I3hmCUwUOjB8JOWB2KB6RNqBc8nr6meIVgGfpbtqRB
         w4g1WTQi2/O4wwTlPhAYexTt0UuCHDDHplZBLrSepPrO5IT46HiKl3jWMFoi3TAO0DQo
         tkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701268893; x=1701873693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyYsrVXR9VfHQeLrjs7Rji7raTyh+wNRCcIFYzXejwI=;
        b=Yww9GIXiGbyMGSKR0YplV8YPtMdRFg/aogAmWZ5dunlSXOvhbFs7iDULQjvJ6XqyII
         TNPQvmr4yJ6gKmcktGBNvjgjGKNIKOr+vdTn15hNENHhlmWLkAtip+IYav8PP+65zXne
         4YfMuVkF1oZAwuzk240JBipAnQE1N5NWfKg3ndrB2d5BEKlE4HRwau8UWT+lS/MdVcd9
         O/SDjriRl7X5oQYanMrZhBjJdM4ODkrg19XnmiTLArQMqXAFpBDAr0Js/SSnGKDLtyEW
         PKiuIBma0FXLAJd+if2s2sPT3NQfkClHUzPwSMIbA9j0aNOjYBX1nYlIkNJuBLLXSf+e
         Rnaw==
X-Gm-Message-State: AOJu0YxB4byXFmi50gb77t4G/loH6EoRIkZc9g/Ix7zYyfuyHV1n39hi
        2aWBKb/KHpJhFCMAKkrdIFg5zA==
X-Google-Smtp-Source: AGHT+IHbWCQjyNsC/fDqwswBwuL8Ht4forXS21KOSAiBuCRNt8Yv7qu5c2eiDsLfudjMrXbWoHZ7aw==
X-Received: by 2002:a50:cd9d:0:b0:54b:5243:f7d6 with SMTP id p29-20020a50cd9d000000b0054b5243f7d6mr7475815edi.32.1701268893292;
        Wed, 29 Nov 2023 06:41:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o24-20020aa7c7d8000000b005432f45bee9sm7311740eds.19.2023.11.29.06.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:41:32 -0800 (PST)
Date:   Wed, 29 Nov 2023 15:41:31 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Bahadur, Sachin" <sachin.bahadur@intel.com>
Cc:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net v4] ice: Block PF reinit if attached to bond
Message-ID: <ZWdNm5pnmZsrO874@nanopsycho>
References: <20231127060512.1283336-1-sachin.bahadur@intel.com>
 <ZWRkN12fhENyN4PY@nanopsycho>
 <BY5PR11MB42574D2A64F2C4E42400213A96BDA@BY5PR11MB4257.namprd11.prod.outlook.com>
 <ZWWYx18w2BnLyAZL@nanopsycho>
 <BY5PR11MB42574A519BF05AF80BC03E1A96BCA@BY5PR11MB4257.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB42574A519BF05AF80BC03E1A96BCA@BY5PR11MB4257.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Nov 28, 2023 at 06:45:47PM CET, sachin.bahadur@intel.com wrote:
>
>
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Monday, November 27, 2023 11:38 PM
>> To: Bahadur, Sachin <sachin.bahadur@intel.com>
>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH iwl-net v4] ice: Block PF reinit if attached to bond
>> 
>> Mon, Nov 27, 2023 at 05:23:55PM CET, sachin.bahadur@intel.com wrote:
>> >
>> >> Nack. Remove the netdev during re-init, that would solve your issue.
>> >> Looks like some checks are needed to be added in devlink code to make
>> >> sure drivers behave properly. I'm on in.
>> >
>> >Sure. This fix should apply to all drivers. Adding it in devlink makes
>> >more sense. I am not a devlink expert, so I hope you or someone else
>> >can help with it.
>> 
>> No, you misunderstood. I'll just add a check-warn in devlink for case when port
>> exists during reload. You need to fix it in your driver.
>
>
>What should be fixed in my driver. Can you clarify ? 
>And are suggesting I add the check-warn in devlink code ?

Remove the netdev during re-init.


>
>
>> >
>> >>
>> >>
>> >> >+			return -EBUSY;
>> >> >+		}
>> >> > 		ice_unload(pf);
>> >> > 		return 0;
>> >> > 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>> >> >--
>> >> >2.25.1
>> >> >
>> >> >

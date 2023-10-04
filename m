Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EEA7B7724
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbjJDEae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbjJDEab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:30:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D259AD;
        Tue,  3 Oct 2023 21:30:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c76ef40e84so2720195ad.0;
        Tue, 03 Oct 2023 21:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696393828; x=1696998628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2YAoKhlpp4bkGIM7O8IZilAS5B+0Et8jSoMZQYN7n2w=;
        b=FXzBCanZhS8vf78qKTW9q3xI4Pobi62EmgRzoPijFeZumT+i3bZxA1UPK6fsAdJgM+
         jbDfIicVmY32N9aisgqIjFivnoU5XuQlhZqEDRnuFIi44BKBrnM97QNqdKMgzOwPhiFf
         Or12K7EDKsdBa9H2+2mMRhChZQ1oZzw4zXsSwORO1q1OdpypeUh7J4ugBajIQD/hnjkx
         MgtGKnTz2ghRdAIpek+7ThjKbdoEbcDKIcIsnBDlCyeEXbNzkIi1daxxWU8TNAO+CVV9
         WLkAVAvFJ0yzG4pGClVElYKwUdEVXxz9c3LpkcZIIjZegvaIAqLKZ05QeRAr0pbKybyf
         gcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696393828; x=1696998628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YAoKhlpp4bkGIM7O8IZilAS5B+0Et8jSoMZQYN7n2w=;
        b=NocC9c0Jcz+WjLr1XlLjVI2gYXBc+7pWEJCgZQm9FwS2pFAFxDxnYgRhWn4ibdRq1m
         XNleY5cRtMbMq0IEmTWrsepMSntsH/AzV5Jado8spSstIomqO8sQpZRt3dKWMq9C3wpl
         eTbnp6MkHzqmc+qxIh+kM7d+mh1lURhIRQXojDWzdHVhUGRtRrYxX3RYRjr2/yVMTuBA
         6pT9cS2SHStqId35eXCddGGASyQP4bu1S2QNnEnUcyTlekX+V4f5arvdkDl3jv6nPI+q
         /53svdG9v+pl25TCQAawSvdwUYDZ3V++jTQkUlaEJY6m5z+cN4e2NiPfUFeMjKDpPIg2
         /9NQ==
X-Gm-Message-State: AOJu0YxW2CjWzCx8VMotz1u/r1KVlAFejsszZSkTv5+P9fFem22ok0TB
        zKdu7blcynkj7gLtGttc4HY=
X-Google-Smtp-Source: AGHT+IH7VT/+9NumebcULZSqHBHMbm9i15ayaFnpXpxOADuu/BRDBsnEV5u55QliQI+WA0VTKnHQlg==
X-Received: by 2002:a05:6a20:a123:b0:13f:65ca:52a2 with SMTP id q35-20020a056a20a12300b0013f65ca52a2mr1460033pzk.5.1696393827728;
        Tue, 03 Oct 2023 21:30:27 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id q16-20020a62ae10000000b0069302c3c050sm2189665pff.218.2023.10.03.21.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 21:30:27 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:30:24 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Mahesh Bandewar <maheshb@google.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        John Stultz <jstultz@google.com>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCHv2 next 2/3] ptp: add ioctl interface for
 ptp_gettimex64any()
Message-ID: <ZRzqYO2eV9Lmm8+O@hoboy.vegasvil.org>
References: <20231003041704.1746303-1-maheshb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003041704.1746303-1-maheshb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:17:04PM -0700, Mahesh Bandewar wrote:
> add an ioctl op PTP_SYS_OFFSET_ANY2 to support ptp_gettimex64any() method

NAK.

> +	case PTP_SYS_OFFSET_ANY2:

2?

What happended to 1?

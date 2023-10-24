Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3F7D5089
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjJXNAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjJXNAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:00:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E336DD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:00:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a55302e0so6017242e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698152446; x=1698757246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9mkSvzL5AlqEqCk4gL6PQxVO/Ut1Am/gjPnbui/hZY=;
        b=iqQEM5+DZq6rYuXpysfHPdOjEbXqRzY492KBz3FbKcY1PZAHYtnqFDhri13UbyGkLt
         9qMt8/4VtBKaoeFifAclx68R7mjIWG0ld1kf+xLkiZAoUiyeVTehC3qbBVIe+ZI5HN6g
         6GSuRNHMsTLoD6kaEJOkjGKq20YO0PVEEqF9SNILOpslZ2FUZDSnIW1AQnXFbxVizKA7
         HRPSFC7+/BOhKTA4rOe3CtH3OzY8OqZFhOQmW295bLsbrbqeqce0v6qYAfdS/tI7RIrM
         M06vk2cnSV7Ix3BNsXvryD6c/anf9JacFFn+zLyv8oS2zxKQuwh0qubEgj7ABIkFXQlf
         w3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698152446; x=1698757246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9mkSvzL5AlqEqCk4gL6PQxVO/Ut1Am/gjPnbui/hZY=;
        b=uweDJGEO/2j18iHJo+m8irybMwD68V60T+HA9VBdZ7SGFBVXtuAgXMvU0y8lwnNIvH
         Y8EQgmZrHtR12VMqptHWhxT8o0PB9azkcOR4qJbThsINt//Ikjg+z7xqhMAXVpL3eqrk
         tqtnb7QICZbe6Qoc451BB7YyBIyyvJuydiDdl1Lt7+eolNbJ9Etj4KPv03lbkNXTJ7xh
         4195jkDxwZL2gEfPy1YFtN+ZxKQHb7E+R1hUfrg2c+zh10CtUZonzz/CS3SIqyzjLk1x
         Oxg5ShgemmY4zO+wrGQft/ocTs7psR3AFlXUQZk6EjjTmmXQ1exTdQi/adDOeLuGnGp/
         AjYw==
X-Gm-Message-State: AOJu0YyH8b2J4vEHKN1Jeao/0YYH4FEY4JHkFDPYSY/w8nNkK3PSrl4J
        y2aqxOzedY5RP8GTqs4ziu0skA==
X-Google-Smtp-Source: AGHT+IF0yE6XO/mX2TbNGtNxqeLgtwKSWDprIrmqOUxkx9EVlX98W4Y61rPzb7TU1zWbcCeFWoQKdA==
X-Received: by 2002:ac2:532a:0:b0:507:9777:7a7 with SMTP id f10-20020ac2532a000000b00507977707a7mr8516878lfh.17.1698152446332;
        Tue, 24 Oct 2023 06:00:46 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id gy5-20020a0564025bc500b0053d9cb67248sm7728993edb.18.2023.10.24.06.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:00:45 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:00:44 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 2/2] i40e: Fix devlink port unregistering
Message-ID: <ZTe//IyJUl10iFYI@nanopsycho>
References: <20231024125109.844045-1-ivecera@redhat.com>
 <20231024125109.844045-2-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024125109.844045-2-ivecera@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Oct 24, 2023 at 02:51:09PM CEST, ivecera@redhat.com wrote:
>Ensure that devlink port is unregistered after unregistering
>of net device.
>
>Reproducer:
>[root@host ~]# rmmod i40e
>[ 4742.939386] i40e 0000:02:00.1: i40e_ptp_stop: removed PHC on enp2s0f1np1
>[ 4743.059269] ------------[ cut here ]------------
>[ 4743.063900] WARNING: CPU: 21 PID: 10766 at net/devlink/port.c:1078 devl_port_unregister+0x69/0x80
>...
>
>Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

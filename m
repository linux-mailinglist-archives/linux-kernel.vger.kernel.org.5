Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994B17D5086
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjJXNAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjJXNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:00:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3381010C2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:00:34 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so6961042a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698152432; x=1698757232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWgZj0jWXyKIUpIqseNDFQ+Z3Ajt56Y9J6kThz0DfLU=;
        b=2sD6BBIQO1lj4Kwx720Zfg3rgFovVh7nNSRRwmuXUB3v5G+YauzDqwDTC1LmFpghgH
         /IAI3ZuZHVMQo4sTKradRg0zgX2lt1zERwEI7uCMhoqKExPfeZxnAdA9OAQ7Vdr6JpcU
         QjLNvOc/+CZDjY6qPmJsWxpxSkUcTX7I4hDvAHxzrhRN05LzgVFIR+pA+SMEKo+BlFdb
         3sl/H1GmcwAhntF90SsdLNrhWhWV9htkV2irNgOvi71rtKiUijJ24h0hoFB01/FH94vO
         xSbgofR44bkZsrJZOTYSrZOLwp0ITuwOwtf/pLro5/2xQAPOoNZkCzWZoJRPaBUJws3L
         ZadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698152432; x=1698757232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWgZj0jWXyKIUpIqseNDFQ+Z3Ajt56Y9J6kThz0DfLU=;
        b=ra7h7OSW+uoAsX7Dz9fCukH+lWvDRhjn4C3Px0pFe45VP0jM+jmL0OfPDbwG/62pXW
         ttgi/iOgpg5em+b7taAo4Y1vVx+DxecM0MBLFOPZl7nJfQTmPuGUiyQ1U5XDhLgnbrsY
         uPaGxeyZefgXilt1T8T/4H7LENtV+yTHgwePzRqdbar2Lwpabw3pIxHAyu1QVrQIhUE4
         6BQ8ulaF3DIesAEICwOJ9Za3g7EsfXZCyclFWCsq7VkawWnd/RaE9UgfiO/r0rloRWFM
         +yMW+gWlVa/rhXMQEoh/kcYRsIr9h/y8U2z3OyZR0Aj0Sr+vAetvL2tUa5z4qVe4Xea/
         rm8A==
X-Gm-Message-State: AOJu0YwXruNJ91eJqMZGnjy2x1uZUCVtTIcx4EozkzRoDXSnKeCzxxDt
        Fi7APOgesB39wN0WGy2ZzCw+Eg==
X-Google-Smtp-Source: AGHT+IEzcpYTuCTOHF/4/6Ur1ISFMPTfgKZaV6/zztDjAlr47wbdwfa+ojve+Wi/F7riNzmSUNX+5g==
X-Received: by 2002:a50:d603:0:b0:53e:6624:5aeb with SMTP id x3-20020a50d603000000b0053e66245aebmr9243046edi.11.1698152432557;
        Tue, 24 Oct 2023 06:00:32 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h28-20020a50cddc000000b0053e589016a7sm7980698edj.16.2023.10.24.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:00:31 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:00:30 +0200
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
Subject: Re: [PATCH net-next 1/2] i40e: Do not call devlink_port_type_clear()
Message-ID: <ZTe/7nfMmS+6KhrE@nanopsycho>
References: <20231024125109.844045-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024125109.844045-1-ivecera@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Oct 24, 2023 at 02:51:08PM CEST, ivecera@redhat.com wrote:
>Do not call devlink_port_type_clear() prior devlink port unregister
>and let devlink core to take care about it.
>
>Reproducer:
>[root@host ~]# rmmod i40e
>[ 4539.964699] i40e 0000:02:00.0: devlink port type for port 0 cleared without a software interface reference, device type not supported by the kernel?
>[ 4540.319811] i40e 0000:02:00.1: devlink port type for port 1 cleared without a software interface reference, device type not supported by the kernel?
>
>Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Ivan, I see that even if we have checks and warnings, it is not enough :)

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Btw, some (even brief) cover letter for patchset would be nice.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979287DC10A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjJ3UPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjJ3UPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690EBF7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698696897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zWGfMOu7F7kKUs5HJBbLfJGB4P8zWxfoMGodA/8nKgs=;
        b=attmn29XAl7x+L5yTUgpH7AFi4IroT9fHxHR33wbHMp5/gSCLSKJP6Xxx96zDsbVGoK/HF
        3+k1voa/f5ZtAgoTuh0sdPJ3dcvrjS0W0DxXmOanQp0AhfiYrqKeflHh63PoiyJZAXOGBc
        oGE2GVJGUHHNo/xk+jLtVl4KJCtH8KM=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-myIf_hdXM0C14JfJgnCNbQ-1; Mon, 30 Oct 2023 16:14:46 -0400
X-MC-Unique: myIf_hdXM0C14JfJgnCNbQ-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-79499607027so438007241.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698696886; x=1699301686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWGfMOu7F7kKUs5HJBbLfJGB4P8zWxfoMGodA/8nKgs=;
        b=fmS8i5bdSzgUvz73IKa8S3ZX+G/GjFHt8nb6qRjTnHijA4MzOlIiAUhiwYPDk5ADtW
         peEskAa8vq9c2LFiA+kLdSrvFUsUCKnVmXUQWGjydEGVQLbQiAvH5A1tsvQZo/50QO24
         EAM1gWIr3dG4d3LidROj6TNIIYA00XHSZg0em8RUHavcEFU02ZAAZhfAWn0CkivtVgE8
         Fd2vdqE3fGiSySJn1ck2wyKMHp0ZIKLEDIRmxvQAr2tACMZ4ESEPg4iIMEBQXyTSo7ZJ
         xIh+NX+aHOVdgXkoffRO372Gqbr+6U3YM7P5lZfQlPe8fm6E3PBUEvA34rZCHZNq2Xee
         LAag==
X-Gm-Message-State: AOJu0Yy5mAyTAYPzbRUibbqtV+bVGiAbbTC1K3I4UHBAiYy/E4IpOXu5
        urb1hDrLCCWJ05RW6J1yUE+VhnI+hjQjhT4BbZxJt3+9JqgHhgvnIkkG5rW51JDFJOC0i3GEcDU
        XrGs/9k5o+CD5Tguj/npLzxYA
X-Received: by 2002:a05:6102:914:b0:454:7a81:b30a with SMTP id x20-20020a056102091400b004547a81b30amr9263794vsh.0.1698696885456;
        Mon, 30 Oct 2023 13:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpG5KIh6bv0/spHSBWngU4H0SaI7+Bd7c85laDovrwWadeNA9ZKAwXd1Hhen8C8UCCLPNlZQ==
X-Received: by 2002:a05:6102:914:b0:454:7a81:b30a with SMTP id x20-20020a056102091400b004547a81b30amr9263776vsh.0.1698696885190;
        Mon, 30 Oct 2023 13:14:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id z11-20020a0cfc0b000000b006564afc5908sm3707026qvo.111.2023.10.30.13.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:14:44 -0700 (PDT)
Date:   Mon, 30 Oct 2023 16:14:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 3/5] selftests/mm: call uffd_test_ctx_clear at the end
 of the test
Message-ID: <ZUAOsn9Fj/qCo+xg@x1n>
References: <20231028003819.652322-1-surenb@google.com>
 <20231028003819.652322-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231028003819.652322-4-surenb@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:38:13PM -0700, Suren Baghdasaryan wrote:
> uffd_test_ctx_clear() is being called from uffd_test_ctx_init() to unmap
> areas used in the previous test run. This approach is problematic because
> while unmapping areas uffd_test_ctx_clear() uses page_size and nr_pages
> which might differ from one test run to another.
> Fix this by calling uffd_test_ctx_clear() after each test is done.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


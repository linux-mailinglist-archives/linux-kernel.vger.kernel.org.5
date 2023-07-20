Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5E375A82A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjGTHuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjGTHuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:50:07 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2CE212C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:49:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso276057b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689839397; x=1690444197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5v+Yb0ANIW+fgKgy1VxAvgl9Xauo9gH9pbWm/MAyZ6U=;
        b=Ba3bkntdhbXV7ImgnB1Nrt5e7PQN5x9RpS5BsuSjM64VLK13sBF9Og78VXLGdr6Pi6
         9wRt2MaRkmJ/ydHtRNDBf9BGX6ZcfNe1Kq7fVm6xY3uEJGpwB18lBmYXvGqYCZ6wle0z
         7q8mS9dE1RgSGxkCEVR2YcWZG9GsSTg3r/bo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689839397; x=1690444197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v+Yb0ANIW+fgKgy1VxAvgl9Xauo9gH9pbWm/MAyZ6U=;
        b=UnetGm10d1p3uZ3xVn1IZKUaUrsxN0q6ooc2ZRid0i0TdBAfYdN5T2mY7y9catULYu
         sjygepTC44EHUE1M3xPlQ3ZmchgOX7B8B6DkEqYEy1HAP25Az3lyKdqMBEWcGqOad2MT
         0Wmpv7PAtPn44aQ18GsM09cD1ite4TyuoG0KP2bWda9xrSwxdltTqUC/TwgMaTAhwgOS
         /0c0/R/3G8TgFYvoC2vsCnJOAu6Vle1xhja52epMaNh+MjRQfRhwVk319J5onbofzi/l
         rlrvyumZMpWa4GFe2kZcQNGoOZLM9fcXReK2qSyCT1wGW603BkCXErk7Tkvow3ZKMtQ+
         5pJg==
X-Gm-Message-State: ABy/qLanyIu7Ih9iBU0FWUsyU0eDY1ga9L7sSZZy3a4YXFcH6vBIA+C2
        xoKjnR+GVnH0FJ7chJCul7jyZQ==
X-Google-Smtp-Source: APBJJlFfdmRuogpQp3SvrrWLugvmyJjnZzO0FLl6jmtPyDobvIqnHqljrJhHnRMOHFwhVE7QpWuCbw==
X-Received: by 2002:a05:6a21:6d8b:b0:125:4c0b:93cd with SMTP id wl11-20020a056a216d8b00b001254c0b93cdmr20664298pzb.34.1689839397432;
        Thu, 20 Jul 2023 00:49:57 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:648f:4ec7:23d9:d855])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001b83db0bcf2sm588818plb.141.2023.07.20.00.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:49:57 -0700 (PDT)
Date:   Thu, 20 Jul 2023 16:49:53 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC PATCH v2 16/21] mm/zsmalloc: convert location_to_obj() to
 use zsdesc
Message-ID: <20230720074953.GG955071@google.com>
References: <20230713042037.980211-1-42.hyeyoo@gmail.com>
 <20230713042037.980211-17-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713042037.980211-17-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/13 13:20), Hyeonggon Yoo wrote:
>  /**
> - * location_to_obj - get obj value encoded from (<page>, <obj_idx>)
> - * @page: page object resides in zspage
> + * location_to_obj - get obj value encoded from (<zsdesc>, <obj_idx>)
> + * @zsdesc object resides in zspage

      @zsdesc:

>   * @obj_idx: object index
>   */

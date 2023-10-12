Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C947C7328
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378915AbjJLQgk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 12:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbjJLQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:36:37 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A49C6;
        Thu, 12 Oct 2023 09:36:35 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57b83ff7654so123363eaf.1;
        Thu, 12 Oct 2023 09:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128594; x=1697733394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xn2d1ZalxgHpJArrXkOlMAYABXDVS3l+5vwuPAudUHw=;
        b=F2Q1mxzqWyw5AXjqAZW4c4m9EzrQNsPiHL+ns+XDoMi6hzP3woPEFbCEozwivDkGsy
         BEwisHh0YMmPT+vmTaovFc3ABASzE019xRWBgzfP1giCeNArzwzs1hbqYJl4V9FXU1yE
         O7iJ2OhGKXuqizr5tjghk0IOHa4/eQhrWSOU3fQFtcGDYhkkxux/5GHZEONmwmFjBatZ
         +v8BNQyKg2o6LpTT44xpqTVC1g9Tegn4MKF7MJ1AXFsCYI54imwCi6lOe2H8QF8jYUao
         ALmZE1zjSWEZREk5v9QoYRlP24viXeBggQ767E1dQDvQRIT8qeoiYcLhojhX8CM4dHOq
         G0sA==
X-Gm-Message-State: AOJu0YyGlASl8lpEhx5NMDs4xe/R0vr3KGlCPnxwb6xamDRxWMp2JQRR
        wNXtJpqdHCfySbLPst7hSgS88Bbq3TzV5rZj5JA=
X-Google-Smtp-Source: AGHT+IEm3hpOsQVoGeL5Jq1J13Yx/bJ+WwUrMPDPdGBNCHLYJxM6aXHmYxTLIuKhLsOMwnjzTY2wvQ7iTl5ug6vHFzE=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr22964211ooo.0.1697128594221; Thu, 12 Oct
 2023 09:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <13365827.uLZWGnKmhe@kreacher> <3768557.kQq0lBPeGt@kreacher> <47191d10-354b-415b-b75a-f15a5f8f4cff@linaro.org>
In-Reply-To: <47191d10-354b-415b-b75a-f15a5f8f4cff@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Oct 2023 18:36:23 +0200
Message-ID: <CAJZ5v0h0v-jrEfTq0t8U4wmoVWTgy1Poq4p6AA9H75-GiDUutg@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] thermal: gov_power_allocator: Use trip pointers
 instead of trip indices
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 5:19 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 06/10/2023 19:47, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Modify the power allocator thermal governor to use trip pointers instead
> > of trip indices everywhere except for the power_allocator_throttle()
> > second argument that will be changed subsequently along with the
> > definition of the .throttle() governor callback.
> >
> > The general functionality is not expected to be changed.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/gov_power_allocator.c |  123 +++++++++++++---------------------
> >   1 file changed, 49 insertions(+), 74 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/gov_power_allocator.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/gov_power_allocator.c
> > +++ linux-pm/drivers/thermal/gov_power_allocator.c
> > @@ -16,8 +16,6 @@
> >
> >   #include "thermal_core.h"
> >
> > -#define INVALID_TRIP -1
> > -
> >   #define FRAC_BITS 10
> >   #define int_to_frac(x) ((x) << FRAC_BITS)
> >   #define frac_to_int(x) ((x) >> FRAC_BITS)
> > @@ -55,23 +53,23 @@ static inline s64 div_frac(s64 x, s64 y)
> >    * @err_integral:   accumulated error in the PID controller.
> >    * @prev_err:       error in the previous iteration of the PID controller.
> >    *          Used to calculate the derivative term.
> > + * @sustainable_power:       Sustainable power (heat) that this thermal zone can
> > + *                   dissipate
> >    * @trip_switch_on: first passive trip point of the thermal zone.  The
> >    *                  governor switches on when this trip point is crossed.
> >    *                  If the thermal zone only has one passive trip point,
> > - *                   @trip_switch_on should be INVALID_TRIP.
> > + *                   @trip_switch_on should be NULL.
> >    * @trip_max_desired_temperature:   last passive trip point of the thermal
> >    *                                  zone.  The temperature we are
> >    *                                  controlling for.
> > - * @sustainable_power:       Sustainable power (heat) that this thermal zone can
> > - *                   dissipate
> >    */
> >   struct power_allocator_params {
> >       bool allocated_tzp;
> >       s64 err_integral;
> >       s32 prev_err;
> > -     int trip_switch_on;
> > -     int trip_max_desired_temperature;
> >       u32 sustainable_power;
> > +     const struct thermal_trip *trip_switch_on;
> > +     const struct thermal_trip *trip_max_desired_temperature;
> >   };
> >
> >   /**
> > @@ -90,14 +88,12 @@ static u32 estimate_sustainable_power(st
> >       u32 sustainable_power = 0;
> >       struct thermal_instance *instance;
> >       struct power_allocator_params *params = tz->governor_data;
> > -     const struct thermal_trip *trip_max_desired_temperature =
> > -                     &tz->trips[params->trip_max_desired_temperature];
> >
> >       list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> >               struct thermal_cooling_device *cdev = instance->cdev;
> >               u32 min_power;
> >
> > -             if (instance->trip != trip_max_desired_temperature)
> > +             if (instance->trip != params->trip_max_desired_temperature)
> >                       continue;
> >
> >               if (!cdev_is_power_actor(cdev))
> > @@ -116,24 +112,23 @@ static u32 estimate_sustainable_power(st
> >    * estimate_pid_constants() - Estimate the constants for the PID controller
> >    * @tz:             thermal zone for which to estimate the constants
> >    * @sustainable_power:      sustainable power for the thermal zone
> > - * @trip_switch_on:  trip point number for the switch on temperature
> > + * @trip_switch_on:  trip point for the switch on temperature
> >    * @control_temp:   target temperature for the power allocator governor
> >    *
> >    * This function is used to update the estimation of the PID
> >    * controller constants in struct thermal_zone_parameters.
> >    */
> >   static void estimate_pid_constants(struct thermal_zone_device *tz,
> > -                                u32 sustainable_power, int trip_switch_on,
> > +                                u32 sustainable_power,
> > +                                const struct thermal_trip *trip_switch_on,
> >                                  int control_temp)
> >   {
> > -     struct thermal_trip trip;
> >       u32 temperature_threshold = control_temp;
> >       int ret;
> >       s32 k_i;
> >
> > -     ret = __thermal_zone_get_trip(tz, trip_switch_on, &trip);
> > -     if (!ret)
> > -             temperature_threshold -= trip.temperature;
> > +     if (trip_switch_on)
> > +             temperature_threshold -= trip_switch_on->temperature;
> >
> >       /*
> >        * estimate_pid_constants() tries to find appropriate default
> > @@ -386,7 +381,7 @@ static int allocate_power(struct thermal
> >       struct thermal_instance *instance;
> >       struct power_allocator_params *params = tz->governor_data;
> >       const struct thermal_trip *trip_max_desired_temperature =
> > -                     &tz->trips[params->trip_max_desired_temperature];
> > +                                     params->trip_max_desired_temperature;
> >       u32 *req_power, *max_power, *granted_power, *extra_actor_power;
> >       u32 *weighted_req_power;
> >       u32 total_req_power, max_allocatable_power, total_weighted_req_power;
> > @@ -496,7 +491,7 @@ static int allocate_power(struct thermal
> >   }
> >
> >   /**
> > - * get_governor_trips() - get the number of the two trip points that are key for this governor
> > + * get_governor_trips() - get the two trip points that are key for this governor
> >    * @tz:     thermal zone to operate on
> >    * @params: pointer to private data for this governor
> >    *
> > @@ -513,46 +508,36 @@ static int allocate_power(struct thermal
> >   static void get_governor_trips(struct thermal_zone_device *tz,
> >                              struct power_allocator_params *params)
> >   {
> > -     int i, last_active, last_passive;
> > -     bool found_first_passive;
> > -
> > -     found_first_passive = false;
> > -     last_active = INVALID_TRIP;
> > -     last_passive = INVALID_TRIP;
> > -
> > -     for (i = 0; i < tz->num_trips; i++) {
> > -             struct thermal_trip trip;
> > -             int ret;
> > -
> > -             ret = __thermal_zone_get_trip(tz, i, &trip);
> > -             if (ret) {
> > -                     dev_warn(&tz->device,
> > -                              "Failed to get trip point %d type: %d\n", i,
> > -                              ret);
> > -                     continue;
> > -             }
> > -
> > -             if (trip.type == THERMAL_TRIP_PASSIVE) {
> > -                     if (!found_first_passive) {
> > -                             params->trip_switch_on = i;
> > -                             found_first_passive = true;
> > -                     } else  {
> > -                             last_passive = i;
> > +     const struct thermal_trip *first_passive = NULL;
> > +     const struct thermal_trip *last_passive = NULL;
> > +     const struct thermal_trip *last_active = NULL;
> > +     const struct thermal_trip *trip;
> > +
> > +     for_each_trip(tz, trip) {
> > +             switch (trip->type) {
> > +             case THERMAL_TRIP_PASSIVE:
> > +                     if (!first_passive) {
> > +                             first_passive = trip;
> > +                             break;
> >                       }
> > -             } else if (trip.type == THERMAL_TRIP_ACTIVE) {
> > -                     last_active = i;
> > -             } else {
> > +                     last_passive = trip;
> > +                     break;
> > +             case THERMAL_TRIP_ACTIVE:
> > +                     last_active = trip;
> > +                     break;
> > +             default:
> >                       break;
> >               }
> >       }
> >
> > -     if (last_passive != INVALID_TRIP) {
> > +     if (last_passive) {
> > +             params->trip_switch_on = first_passive;
> >               params->trip_max_desired_temperature = last_passive;
> > -     } else if (found_first_passive) {
> > -             params->trip_max_desired_temperature = params->trip_switch_on;
> > -             params->trip_switch_on = INVALID_TRIP;
> > +     } else if (first_passive) {
> > +             params->trip_switch_on = NULL;
> > +             params->trip_max_desired_temperature = first_passive;
> >       } else {
> > -             params->trip_switch_on = INVALID_TRIP;
> > +             params->trip_switch_on = NULL;
> >               params->trip_max_desired_temperature = last_active;
> >       }
> >   }
> > @@ -567,14 +552,12 @@ static void allow_maximum_power(struct t
> >   {
> >       struct thermal_instance *instance;
> >       struct power_allocator_params *params = tz->governor_data;
> > -     const struct thermal_trip *trip_max_desired_temperature =
> > -                     &tz->trips[params->trip_max_desired_temperature];
> >       u32 req_power;
> >
> >       list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> >               struct thermal_cooling_device *cdev = instance->cdev;
> >
> > -             if ((instance->trip != trip_max_desired_temperature) ||
> > +             if (instance->trip != params->trip_max_desired_temperature ||
> >                   (!cdev_is_power_actor(instance->cdev)))
> >                       continue;
> >
> > @@ -636,7 +619,6 @@ static int power_allocator_bind(struct t
> >   {
> >       int ret;
> >       struct power_allocator_params *params;
> > -     struct thermal_trip trip;
> >
> >       ret = check_power_actors(tz);
> >       if (ret)
> > @@ -662,12 +644,13 @@ static int power_allocator_bind(struct t
> >       get_governor_trips(tz, params);
> >
> >       if (tz->num_trips > 0) {
>
> Maybe this test can go away because if (trip) is true below, then
> logically (tz->num_trips > 0) ?

Yes, it can go away.

> > -             ret = __thermal_zone_get_trip(tz, params->trip_max_desired_temperature,
> > -                                           &trip);
> > -             if (!ret)
> > +             const struct thermal_trip *trip;
> > +
> > +             trip = params->trip_max_desired_temperature;
> > +             if (trip)
> >                       estimate_pid_constants(tz, tz->tzp->sustainable_power,
> >                                              params->trip_switch_on,
> > -                                            trip.temperature);
> > +                                            trip->temperature);
> >       }
> >
> >       reset_pid_controller(params);
> > @@ -697,11 +680,10 @@ static void power_allocator_unbind(struc
> >       tz->governor_data = NULL;
> >   }
> >
> > -static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
> > +static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_index)
> >   {
> >       struct power_allocator_params *params = tz->governor_data;
> > -     struct thermal_trip trip;
> > -     int ret;
> > +     const struct thermal_trip *trip = &tz->trips[trip_index];
> >       bool update;
> >
> >       lockdep_assert_held(&tz->lock);
> > @@ -710,12 +692,12 @@ static int power_allocator_throttle(stru
> >        * We get called for every trip point but we only need to do
> >        * our calculations once
> >        */
> > -     if (trip_id != params->trip_max_desired_temperature)
> > +     if (trip != params->trip_max_desired_temperature)
> >               return 0;
> >
> > -     ret = __thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
> > -     if (!ret && (tz->temperature < trip.temperature)) {
> > -             update = (tz->last_temperature >= trip.temperature);
> > +     trip = params->trip_switch_on;
> > +     if (trip && tz->temperature < trip->temperature) {
> > +             update = tz->last_temperature >= trip->temperature;
> >               tz->passive = 0;
> >               reset_pid_controller(params);
> >               allow_maximum_power(tz, update);
> > @@ -724,14 +706,7 @@ static int power_allocator_throttle(stru
> >
> >       tz->passive = 1;
> >
> > -     ret = __thermal_zone_get_trip(tz, params->trip_max_desired_temperature, &trip);
> > -     if (ret) {
> > -             dev_warn(&tz->device, "Failed to get the maximum desired temperature: %d\n",
> > -                      ret);
> > -             return ret;
> > -     }
> > -
> > -     return allocate_power(tz, trip.temperature);
> > +     return allocate_power(tz, params->trip_max_desired_temperature->temperature);
> >   }
> >
> >   static struct thermal_governor thermal_gov_power_allocator = {
> >
> >
> >
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
